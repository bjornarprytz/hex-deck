class_name DrawPile
extends Node2D

@onready var _cardCountLabel: RichTextLabel = $CardCount
@onready var _pileInfo: PileInfo = $PileInfo

var cards: Array[CardData] = []

func add_cards(cardsToAdd: Array[CardData]):
	for card in cardsToAdd:
		tuck_card(card)
	shuffle()

func shuffle():
	cards.shuffle()

func tuck_card(cardData: CardData):
	cards.push_back(cardData)
	_update_card_count()

func push_card(cardData: CardData):
	cards.push_front(cardData)
	_update_card_count()

func pop_card() -> CardData:
	var card = cards.pop_front()
	_update_card_count()
	return card

func _update_card_count():
	_cardCountLabel.text = str(cards.size())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_pileInfo.hide()

func _on_color_pressed() -> void:
	if _pileInfo.visible:
		_pileInfo.hide()
	else:
		_pileInfo.show()
		_pileInfo.cards = cards
