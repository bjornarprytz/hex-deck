extends Node2D

@onready var card_spawner = preload("res://cards/card.tscn")
@onready var map : Map = $Map
@onready var hand : Hand = $Hand
@onready var deck : Deck = $Deck
@onready var state : StateChart = $State
@onready var pass_button : Button = $PassTurn

var cardToPlay : Card
var orientation_degrees: int

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
	Play.cardReleased.connect(_finish_play_action, CONNECT_ONE_SHOT)
	cardToPlay.position = $Focus.position
func _play_card_physics_processing(delta: float) -> void:
	pass # Replace with function body.
func _play_card_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				orientation_degrees = (orientation_degrees + 60) % 360
			MOUSE_BUTTON_WHEEL_DOWN:
				orientation_degrees = (orientation_degrees - 60) % 360
			MOUSE_BUTTON_RIGHT:
				state.send_event("cancel")
func _off_play_card() -> void:
	pass # Replace with function body.

func _finish_play_action(card: Card):
	assert(card == cardToPlay)
	# Check valid target
	# Abort or resolve
	var tile = map.get_tile_from_point(get_global_mouse_position())
	
	if tile == null:
		state.send_event("cancel")

# MAIN/RESOLVE CARD
func _on_resolve_card() -> void:
	pass # Replace with function body.


# CLEAN UP
func _on_clean_up() -> void:
	for card in hand.cards:
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

