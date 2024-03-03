extends Node2D

@onready var structurePlacementSpawner = preload("res://cards/structure_placement.tscn")
@onready var map : Map = $Map
@onready var hand : Hand = $Hand
@onready var deck : Deck = $Deck
@onready var state : StateChart = $State
@onready var pass_button : Button = $PassTurn
@onready var focusArea : Node2D = $Focus

var cardToPlay : Card
var structurePlacement : StructurePlacement

var score_requirement := 5:
	set(value):
		if (value == score_requirement):
			return
		score_requirement = value
		_update_score()

var current_score = 0:
	set(value):
		if (value == current_score):
			return
		current_score = value
		_update_score()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score()

func _update_score():
	$Score.text = "%d/%d" % [current_score, score_requirement]

func _on_pass_turn() -> void:
	state.send_event("pass turn")

# UPKEEP
func _on_upkeep() -> void:
	for i in range(5):
		Play.draw_card(deck, hand)
	state.send_event("next phase")


# MAIN/IDLE
func _on_idle() -> void:
	pass_button.disabled = false
	Play.cardGrabbed.connect(func(c:Card):
		cardToPlay = c
		state.send_event("play")
		, CONNECT_ONE_SHOT)

func _idle_physics_processing(delta: float) -> void:
	pass # Replace with function body.
func _off_idle() -> void:
	pass_button.disabled = true

# MAIN/PLAY CARD
func _on_play_card() -> void:
	assert(cardToPlay != null)
	Play.tileClicked.connect(_finish_play_action)
	Play.tileHovered.connect(_preview_structure)
	
	cardToPlay.reparent(focusArea)
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(cardToPlay, 'position', Vector2.ZERO, .4)
	
func _play_card_unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.is_pressed()):
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				structurePlacement.rotate_clockwise()
			MOUSE_BUTTON_WHEEL_DOWN:
				structurePlacement.rotate_counterclockwise()
			MOUSE_BUTTON_RIGHT:
				state.send_event("idle")

func _off_play_card() -> void:
	hand.add_card(cardToPlay)
	Play.tileClicked.disconnect(_finish_play_action)
	Play.tileHovered.disconnect(_preview_structure)
	structurePlacement.queue_free()

func _preview_structure(hoveredTile: Tile):
	if (structurePlacement == null):
		structurePlacement = structurePlacementSpawner.instantiate() as StructurePlacement
		structurePlacement.structure = cardToPlay.structurePreview.structure.get_rotated(0)
		add_child(structurePlacement)
	
	structurePlacement.global_position = hoveredTile.global_position
	structurePlacement.check_placement(map, hoveredTile)

func _finish_play_action(targetTile: Tile):
	
	if structurePlacement.check_placement(map, targetTile):
		Play.play_card(cardToPlay, map, targetTile, structurePlacement.rotationSteps)
		state.send_event("idle")

# CLEAN UP
func _on_clean_up() -> void:
	for card in hand.get_cards():
		Play.discard_card(deck, hand, card)
	if (current_score < score_requirement):
		state.send_event("game over")
	else:
		state.send_event("next phase")
func _clean_up_physics_processing(delta: float) -> void:
	pass # Replace with function body.

# GAME OVER
func _on_game_over() -> void:
	pass # Replace with function body.



func _on_state_event_received(event: StringName) -> void:
	print("event received %s" % event)



