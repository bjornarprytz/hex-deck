class_name Hand
extends Area2D

@onready var shape : CollisionShape2D = $Shape

var cards: Array[Card] = []

func add_card(card: Card):
	cards.push_back(card)
	if card.get_parent() != null:
		card.reparent(self)
	else:
		add_child(card)
	_reposition_cards()

func remove_card(card: Card):
	cards.erase(card)
	card.reparent(null)
	_reposition_cards()


func _reposition_cards():
	var i = 0
	for card in cards:
		var h_spacing = card.width + 20.0
		card.position = shape.position + (((h_spacing * i) - (shape.shape.size.x/2.0)) * Vector2.RIGHT)
		i += 1
