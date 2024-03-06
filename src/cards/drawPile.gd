class_name DrawPile
extends Node2D

@onready var cards : Array[CardData] = []

@onready var cardAnchor : Node2D = $Color/CardAnchor
@onready var cardCount : RichTextLabel = $CardCount

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
	cardCount.text = str(cards.size())
