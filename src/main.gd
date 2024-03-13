class_name GameState
extends Node2D

@onready var structurePlacementSpawner = preload ("res://cards/structure_placement.tscn")
@onready var cardSpawner = preload ("res://cards/card.tscn")

@onready var map: Map = $Map
@onready var hand: Hand = $Hand
@onready var drawPile: DrawPile = $DrawPile
@onready var state: StateChart = $MutableState
@onready var pass_button: Button = $PassTurn
@onready var focusArea: Node2D = $Focus

var cardToPlay: Card
var structurePlacement: StructurePlacement

const INITIAL_FOOD_REQUIREMENT := 5
const FOOD_REQUIREMENT_INCREASE = 3

var food: int:
	get:
		return food
	set(value):
		if (value == food):
			return
		var oldValue = food
		food = value
		Events.foodChanged.emit(oldValue, food)

var foodRequirement: int:
	get:
		return foodRequirement
	set(value):
		if (value == foodRequirement):
			return
		var oldValue = foodRequirement
		foodRequirement = value
		Events.foodRequirementChanged.emit(oldValue, foodRequirement)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawPile.add_cards(Meta.deck)
	_update_food()
	Events.foodChanged.connect(_handle_food_change)
	Events.goldChanged.connect(_handle_food_change)
	Events.foodRequirementChanged.connect(_handle_food_change)
	Events.gameOver.connect(func(_result: bool): state.send_event("game over"))

	foodRequirement = INITIAL_FOOD_REQUIREMENT

func _handle_food_change(_oldFood: int, _newFood: int):
	_update_food()

func _update_food():
	$Food.text = "%d/%d" % [food, foodRequirement]
	$Gold.text = "%d" % [Meta.gold]

# UPKEEP
func _on_upkeep() -> void:
	for i in range(5):
		draw_card()
	state.send_event("next phase")

# MAIN/IDLE
func _on_idle() -> void:
	pass_button.disabled = false
	Events.cardGrabbed.connect(func(c: Card):
		cardToPlay=c
		state.send_event("play")
		, CONNECT_ONE_SHOT)
func _off_idle() -> void:
	pass_button.disabled = true

# MAIN/PLAY CARD
func _on_play_card() -> void:
	assert(cardToPlay != null)
	cardToPlay.reparent(focusArea)
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(cardToPlay, 'position', Vector2.ZERO, .4)
	
	structurePlacement = structurePlacementSpawner.instantiate() as StructurePlacement
	structurePlacement.structure = cardToPlay.structure
	structurePlacement.gameState = self
	structurePlacement.card = cardToPlay
	add_child(structurePlacement)
	structurePlacement.confirmed.connect(_confirm_play)
	structurePlacement.aborted.connect(_abort_play)

func _abort_play():
	hand.add_card(cardToPlay)
	state.send_event("idle")

func _confirm_play(args: PlayArgs):
	play_card(args)
	
	var tween = create_tween()
	tween.tween_property(cardToPlay, 'modulate:a', 0.0, .2)
	tween.tween_callback(cardToPlay.queue_free)
	state.send_event("idle")

func _off_play_card() -> void:
	structurePlacement.queue_free()

# CLEAN UP
func _on_clean_up() -> void:
	for card in hand.get_cards():
		discard_card(card)
	
	for placedStructure in map.get_placed_structures():
		var args = PlayArgs.new(self, placedStructure.structure, placedStructure.affectedTiles, placedStructure.get_adjacent_tiles())
		for effect in placedStructure.structure.get_rules().incomeEffects:
			effect.resolve(args)

	if (food < foodRequirement):
		state.send_event("game over")
	else:
		food -= foodRequirement
		foodRequirement += FOOD_REQUIREMENT_INCREASE
		state.send_event("next phase")

# GAME OVER
func _on_game_over() -> void:
	Debug.push_message("Game Over!")

# GAME ACTIONS
func play_card(args: PlayArgs):
	for effect in args.structure.get_rules().placementEffects:
		effect.resolve(args)
	for tile in args.affectedTiles:
		if (tile.placementBonus == null):
			continue
		for effect in tile.placementBonus.rules.placementEffects:
			effect.resolve(args)

	map.place_structure(args.structure, args.affectedTiles)

func draw_card():
	var cardData = drawPile.pop_card()
	
	if (cardData == null):
		Events.gameOver.emit(false)
		return
	
	var card = cardSpawner.instantiate() as Card
	card.data = cardData
	card.global_position = drawPile.cardAnchor.global_position
	
	hand.add_card.call_deferred(card)

func discard_card(card: Card):
	drawPile.tuck_card(card.data)
	card.queue_free()

func _on_pass_turn() -> void:
	state.send_event("pass turn")

func _on_restart_pressed() -> void:
	Meta.reset()
	get_tree().change_scene_to_file("res://main.tscn")
