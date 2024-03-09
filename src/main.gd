class_name GameState
extends Node2D

@onready var structurePlacementSpawner = preload("res://cards/structure_placement.tscn")
@onready var cardSpawner = preload("res://cards/card.tscn")

@onready var map : Map = $Map
@onready var hand : Hand = $Hand
@onready var drawPile : DrawPile = $DrawPile
@onready var state : StateChart = $State
@onready var pass_button : Button = $PassTurn
@onready var focusArea : Node2D = $Focus

var cardToPlay : Card
var structurePlacement : StructurePlacement

var score : int:
	get:
		return score
	set(value):
		if (value == score):
			return
		var oldValue = score
		score = value
		Events.scoreChanged.emit(oldValue, score)

var scoreRequirement : int:
	get:
		return scoreRequirement
	set(value):
		if (value == scoreRequirement):
			return
		var oldValue = scoreRequirement
		scoreRequirement = value
		Events.scoreRequirementChanged.emit(oldValue, scoreRequirement)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drawPile.add_cards(Meta.deck)
	_update_score()
	Events.scoreChanged.connect(_handle_score_change)
	Events.goldChanged.connect(_handle_score_change)
	Events.scoreRequirementChanged.connect(_handle_score_change)
	Events.gameOver.connect(func (_result: bool): state.send_event("game over"))

func _handle_score_change(_oldScore: int, _newScore: int):
	_update_score()

func _update_score():
	$Score.text = "%d/%d" % [score, scoreRequirement]
	$Gold.text = "%d" % [Meta.gold]

# UPKEEP
func _on_upkeep() -> void:
	for i in range(5):
		draw_card()
	state.send_event("next phase")


# MAIN/IDLE
func _on_idle() -> void:
	pass_button.disabled = false
	Events.cardGrabbed.connect(func(c:Card):
		cardToPlay = c
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
	add_child(structurePlacement)
	structurePlacement.confirmed.connect(_confirm_play)
	structurePlacement.aborted.connect(_abort_play)

func _abort_play():
	hand.add_card(cardToPlay)
	state.send_event("idle")

func _confirm_play(targetTile: Tile):
	play_card(cardToPlay, targetTile, structurePlacement.rotationSteps)
	
	var tween = create_tween()
	tween.tween_property(cardToPlay, 'modulate:a', 0.0, .2)
	tween.tween_callback(cardToPlay.queue_free)
	state.send_event("idle")

func _off_play_card() -> void:
	cardToPlay = null
	structurePlacement.queue_free()

# CLEAN UP
func _on_clean_up() -> void:
	for card in hand.get_cards():
		discard_card(card)
	if (score < scoreRequirement):
		state.send_event("game over")
	else:
		state.send_event("next phase")

# GAME OVER
func _on_game_over() -> void:
	Debug.push_message("Game Over!")


# GAME ACTIONS
func play_card(card: Card, targetTile: Tile, rotationSteps: int):
	var rotatedStructure = card.data.structure.get_rotated(rotationSteps)
	var affectedTiles = rotatedStructure.get_affected_tiles(map, targetTile)
	var adjacentTiles = rotatedStructure.get_adjacent_tiles(map, targetTile)
	
	card.structure.alignment.resolve(self, affectedTiles, adjacentTiles)
	map.place_structure(rotatedStructure, affectedTiles)

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
