class_name Draft
extends Node2D

signal choice(cardData: CardData)

@onready var cardSpawner = preload("res://cards/card.tscn")
@onready var cardContainer: HBoxContainer = $Cards

func add_card(cardData: CardData):
	var card = Create.card(cardData)
	card.clicked
	cardContainer.add_child(card)

static func from(cards: Array[CardData]) -> CardData:
	var draft = preload("res://ui/draft.tscn").instantiate() as Draft
	Meta.add_child(draft)
	
	for cardData in cards:
		draft.add_card(cardData)
	
	return await draft.choice
