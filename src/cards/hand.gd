class_name Hand
extends Node2D

signal cardClicked(card: Card)

@onready var cardContainer: Node2D = $Cards

var positionTween: Tween
var selectedCards: Array[Card]

func _ready() -> void:
	cardContainer.child_entered_tree.connect(_card_added)
	cardContainer.child_exiting_tree.connect(_card_removed)

func prompt_pick_one() -> Card:
	selectedCards.clear()
	return await cardClicked

func prompt_pick_n(n: int) -> Array[Card]:
	selectedCards.clear()

	var cardsInHand = get_cards()

	if (cardsInHand.size() <= n):
		return cardsInHand

	while selectedCards.size() < n:
		var card = await cardClicked

		if (selectedCards.has(card)):
			selectedCards.erase(card)
		else:
			selectedCards.push_back(card)
	
	return selectedCards

func get_cards() -> Array[Card]:
	var cards: Array[Card] = []
	for card in cardContainer.get_children():
		assert(card is Card)
		cards.push_back(card)
	return cards

func add_card(card: Card):
	if card.get_parent() != null:
		card.reparent(cardContainer)
	else:
		cardContainer.add_child(card)

func _card_added(card: Card):
	card.clicked.connect(_on_card_clicked)
	_reposition_cards.call_deferred()

func _card_removed(card: Card):
	card.clicked.disconnect(_on_card_clicked)
	_reposition_cards.call_deferred()

func _on_card_clicked(card: Card):
	cardClicked.emit(card)

func _reposition_cards():
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
		if card.is_queued_for_deletion():
			continue
		var h_spacing = card.width + 20.0
		var targetPosition = int(h_spacing * (i - cards.size() / 2.0)) * Vector2.RIGHT
		positionTween.tween_property(card, 'position', targetPosition, .4)
		i += 1
