extends Node2D

@onready var structurePlacementSpawner = preload("res://cards/structure_placement.tscn")
@onready var map : Map = $Map
@onready var hand : Hand = $Hand
@onready var deck : Deck = $Deck
@onready var state : StateChart = $State
@onready var pass_button : Button = $PassTurn
@onready var focusArea : Node2D = $Focus
@onready var message : RichTextLabel = $Message
@onready var rulesText : RichTextLabel = $Rules

var cardToPlay : Card
var structurePlacement : StructurePlacement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score()
	Play.scoreChanged.connect(_handle_score_change)
	Play.goldChanged.connect(_handle_score_change)
	Play.scoreRequirementChanged.connect(_handle_score_change)
	Play.gameOver.connect(func (_result: bool): state.send_event("game over"))

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_TAB:
		rulesText.visible = event.is_pressed()

func _handle_score_change(_oldScore: int, _newScore: int):
	_update_score()

func _update_score():
	$Score.text = "%d/%d" % [Play.score, Play.scoreRequirement]
	$Gold.text = "%d" % [Play.gold]

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
	
	structurePlacement = structurePlacementSpawner.instantiate() as StructurePlacement
	add_child(structurePlacement)
	
func _play_card_unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.is_pressed()):
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				structurePlacement.rotate_clockwise()
			MOUSE_BUTTON_WHEEL_DOWN:
				structurePlacement.rotate_counterclockwise()
			MOUSE_BUTTON_RIGHT:
				state.send_event("idle")
				hand.add_card(cardToPlay)

func _off_play_card() -> void:
	Play.tileClicked.disconnect(_finish_play_action)
	Play.tileHovered.disconnect(_preview_structure)
	structurePlacement.queue_free()

func _preview_structure(hoveredTile: Tile):
	if (structurePlacement.structure == null):
		structurePlacement.structure = cardToPlay.structurePreview.structure.get_rotated(0)
	structurePlacement.global_position = hoveredTile.global_position
	structurePlacement.check_placement(map, hoveredTile)

func _finish_play_action(targetTile: Tile):
	if structurePlacement.check_placement(map, targetTile):
		Play.play_card(cardToPlay, map, targetTile, deck, hand, structurePlacement.rotationSteps)
		
		var tween = create_tween()
		tween.tween_property(cardToPlay, 'modulate:a', 0.0, .2)
		tween.tween_callback(cardToPlay.queue_free)
		state.send_event("idle")

# CLEAN UP
func _on_clean_up() -> void:
	for card in hand.get_cards():
		Play.discard_card(deck, card)
	if (Play.score < Play.scoreRequirement):
		state.send_event("game over")
	else:
		state.send_event("next phase")

# GAME OVER
func _on_game_over() -> void:
	_put_message("Game Over!")

func _on_state_event_received(event: StringName) -> void:
	print("event received %s" % event)


func _put_message(text: String):
	message.text = text
