class_name Deck
extends Node2D

@onready var cards : Array[CardData] = [
	CardData.new("A"),
	CardData.new("B"),
	CardData.new("C"),
	CardData.new("D"),
	CardData.new("E"),
	CardData.new("F"),
	CardData.new("G"),
	CardData.new("H"),
	CardData.new("I"),
	CardData.new("J"),
	CardData.new("L"),
]

@onready var cardAnchor : Node2D = $Color/CardAnchor
@onready var cardCount : RichTextLabel = $CardCount


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
