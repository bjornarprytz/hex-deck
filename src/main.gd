extends Node2D

@onready var structurePlacementSpawner = preload("res://cards/structure_placement.tscn")
@onready var structureSpawner = preload("res://map/placed_structure.tscn")
@onready var cardSpawner = preload("res://cards/card.tscn")

@onready var map : Map = $Map
@onready var hand : Hand = $Hand
@onready var drawPile : DrawPile = $DrawPile
@onready var state : StateChart = $State
@onready var pass_button : Button = $PassTurn
@onready var focusArea : Node2D = $Focus
@onready var message : RichTextLabel = $Message
@onready var rulesText : RichTextLabel = $Rules

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

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_TAB:
		rulesText.visible = event.is_pressed()

func _handle_score_change(_oldScore: int, _newScore: int):
	_update_score()

func _update_score():
	$Score.text = "%d/%d" % [score, scoreRequirement]
	$Gold.text = "%d" % [Meta.gold]

func _on_pass_turn() -> void:
	state.send_event("pass turn")

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
	Events.tileClicked.connect(_finish_play_action)
	Events.tileHovered.connect(_preview_structure)
	
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
	Events.tileClicked.disconnect(_finish_play_action)
	Events.tileHovered.disconnect(_preview_structure)
	structurePlacement.queue_free()

func _preview_structure(hoveredTile: Tile):
	if (structurePlacement.structure == null):
		structurePlacement.structure = cardToPlay.structurePreview.structure.get_rotated(0)
	structurePlacement.global_position = hoveredTile.global_position
	structurePlacement.check_placement(map, hoveredTile)

func _finish_play_action(targetTile: Tile):
	if structurePlacement.check_placement(map, targetTile):
		play_card(cardToPlay, targetTile, structurePlacement.rotationSteps)
		
		var tween = create_tween()
		tween.tween_property(cardToPlay, 'modulate:a', 0.0, .2)
		tween.tween_callback(cardToPlay.queue_free)
		state.send_event("idle")

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
	_put_message("Game Over!")

func _on_state_event_received(event: StringName) -> void:
	print("event received %s" % event)


func _put_message(text: String):
	message.text = text



# GAME ACTIONS


func play_card(card: Card, targetTile: Tile, rotationSteps: int):
	var rotatedStructure = card.data.structure.get_rotated(rotationSteps)
	var affectedTiles = rotatedStructure.get_affected_tiles(map, targetTile)
	var placedStructure = structureSpawner.instantiate() as PlacedStructure
	
	placedStructure.structure = rotatedStructure
	map.add_child(placedStructure)
	placedStructure.position = targetTile.position
	
	for tile in affectedTiles:
		tile.structure = placedStructure.structure
		
	match card.structurePreview.structure.alignment:
		Structure.Alignment.Red:
			var unique_colors : Array[Structure.Alignment] = []
			var adjacents : Array[Tile] = placedStructure.structure.get_adjacent_tiles(map, targetTile)
			for t in adjacents:
				if (t.structure == null):
					continue
				if (!unique_colors.has(t.structure.alignment)):
					unique_colors.push_back(t.structure.alignment)
			score += unique_colors.size()
			
		Structure.Alignment.Yellow:
			var maxCount : int = 0
			var colors : Dictionary = {}
			var adjacents : Array[Tile] = placedStructure.structure.get_adjacent_tiles(map, targetTile)
			for t in adjacents:
				if (t.structure == null):
					continue
				if (!colors.has(t.structure.alignment)):
					colors[t.structure.alignment] = 1
				else:
					colors[t.structure.alignment] += 1
				maxCount = max(colors[t.structure.alignment], maxCount)
				
			score += maxCount
			
		Structure.Alignment.Blue:
			draw_card()
		Structure.Alignment.Green:
			score += 1
		Structure.Alignment.Orange:
			pass
		Structure.Alignment.Purple:
			Meta.gold += 1

func draw_card():
	var cardData = drawPile.pop_card()
	
	if (cardData == null):
		Events.gameOver.emit(false)
		return
	
	var card = cardSpawner.instantiate() as Card
	card.data = cardData
	card.global_position = drawPile.cardAnchor.global_position
	
	hand.add_card(card)

func discard_card(card: Card):
	drawPile.tuck_card(card.data)
	card.queue_free()
