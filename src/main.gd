class_name GameState
extends Node2D

@onready var scoreSpawner = preload ("res://ui/score_coin.tscn")

@onready var map: Map = $Map
@onready var hand: Hand = $Hand
@onready var drawPile: DrawPile = $DrawPile
@onready var state: StateChart = $State
@onready var pass_button: Button = $PassTurn
@onready var focusArea: Node2D = $Focus

var cardToPlay: Card

const FOOD_REQUIREMENT = 25
const TURN_LIMIT = 5

var food: int
var gold: int
var turnsLeft: int = TURN_LIMIT + 1: # +1 because we're starting in the cleanup step
	set(value):
		if value == turnsLeft:
			return
		turnsLeft = value
		$Turns.text = "%d" % [turnsLeft]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawPile.add_cards(Meta.create_deck())
	_update_food()
	Events.foodChanged.connect(_handle_food_change)
	Events.goldChanged.connect(_handle_food_change)
	Events.foodRequirementChanged.connect(_handle_food_change)
	Events.gameOver.connect(func(_result: bool): state.send_event("game over"))

# UPKEEP
func _on_upkeep() -> void:
	for effect in Meta.upkeepRules:
		await effect.resolve(StructureEffectArgs.new(self, null))
	state.send_event("next phase")

# MAIN/IDLE
func _on_idle() -> void:
	pass_button.disabled = false
	
	cardToPlay = await Prompt.oneFromHand(hand, "Pick one card to play")
	state.send_event("play")
	
func _off_idle() -> void:
	pass_button.disabled = true

# MAIN/PLAY CARD
func _on_play_card() -> void:
	assert(cardToPlay != null)
	cardToPlay.reparent(focusArea)
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(cardToPlay, 'position', Vector2.ZERO, .4)
	
	var playEffectArgs = await Prompt.place_structure(self, cardToPlay)

	if playEffectArgs == null:
		_abort_play()
	else:
		_confirm_play(playEffectArgs)

func _abort_play():
	hand.add_card(cardToPlay)
	state.send_event("idle")

func _confirm_play(args: PlayEffectArgs):
	await play_card(args)
	
	cardToPlay.reparent(self)
	var tween = create_tween()
	tween.tween_property(cardToPlay, 'position', drawPile.position, .4)
	tween.tween_callback(discard_card.bind(cardToPlay))
	state.send_event("idle")

# CLEAN UP
func _on_clean_up() -> void:
	for effect in Meta.cleanUpRules:
		await effect.resolve(StructureEffectArgs.new(self, null))

	if (turnsLeft < 0 and food < FOOD_REQUIREMENT):
		state.send_event("game over")
		return
	
	turnsLeft -= 1
	state.send_event("next phase")

# GAME OVER
func _on_game_over() -> void:
	Debug.push_message("Game Over!")
	if (food < FOOD_REQUIREMENT):
		Debug.push_message("Lose")
	else:
		Debug.push_message("Win!")

# GAME ACTIONS
func play_card(args: PlayEffectArgs):
	for effect in Meta.playEffects:
		await effect.resolve(args)
	
	Events.onCardPlayed.emit(args)

func draw_card() -> Card:
	var cardData = drawPile.pop_card()
	
	if cardData == null:
		Debug.push_message("Draw cancelled. Draw pile is empty.")
		return
	
	var card = Create.card(cardData)
	card.global_position = drawPile.global_position
	
	hand.add_card(card)

	return card

func discard_card(card: Card) -> CardData:
	var cardData = card.data
	drawPile.tuck_card(cardData)
	card.queue_free()
	return cardData

func add_food(n: int, source: Array[Tile]=[]):
	var oldValue = food
	food += n
	Events.foodChanged.emit(oldValue, food, source)

func remove_food(n: int, source: Array[Tile]=[]):
	var oldValue = food
	food -= n
	Events.foodChanged.emit(oldValue, food, source)

func add_gold(n: int, source: Array[Tile]=[]):
	var oldValue = gold
	gold += n
	Events.goldChanged.emit(oldValue, gold, source)

func remove_gold(n: int, source: Array[Tile]=[]):
	var oldValue = gold
	gold -= n
	Events.goldChanged.emit(oldValue, gold, source)

func _on_pass_turn() -> void:
	state.send_event("pass turn")

func _on_restart_pressed() -> void:
	Meta.reset()
	get_tree().change_scene_to_file("res://main.tscn")

func _handle_food_change(_oldFood: int, _newFood: int, source: Array[Tile]):
	var tile: Tile
	if source.size() == 0:
		tile = map.get_tile(Map.Coordinates.new(0, 0))
	else:
		tile = source.pick_random()
	
	var coin = scoreSpawner.instantiate() as ScoreCoin

	coin.val = _newFood - _oldFood
	get_tree().root.add_child(coin)
	coin.global_position = tile.global_position
	await create_tween().tween_property(coin, 'global_position', $Food.global_position, .4).finished
	coin.queue_free()

	_update_food()

func _update_food():
	$Food.text = "%d/%d" % [food, FOOD_REQUIREMENT]
	$Gold.text = "%d" % [gold]
