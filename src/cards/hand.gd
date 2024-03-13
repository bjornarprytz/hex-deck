class_name Hand
extends Node2D

@onready var cardContainer : Node2D = $Cards

var positionTween : Tween

func _ready() -> void:
	
	cardContainer.child_entered_tree.connect(_reposition_cards, CONNECT_DEFERRED)
	cardContainer.child_exiting_tree.connect(_reposition_cards, CONNECT_DEFERRED)

func get_cards():
	return cardContainer.get_children() as Array[Card]

func add_card(card: Card):
	if card.get_parent() != null:
		card.reparent(cardContainer)
	else:
		cardContainer.add_child(card)

func _reposition_cards(_node):
	if (!is_node_ready() or !is_inside_tree()):
		return
	
	if positionTween != null:
		positionTween.kill()
	var cards = get_cards()

	if cards.size() == 0:
		return
		
	positionTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC).set_parallel()
	
	var i = 0
	for card in cards:
		var h_spacing = card.width + 20.0
		var targetPosition = int(h_spacing * (i-cards.size() / 2.0) ) * Vector2.RIGHT
		positionTween.tween_property(card, 'position', targetPosition, .4)
		i += 1
