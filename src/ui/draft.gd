class_name Draft
extends Node2D

signal choice(cardData: CardData)

@onready var cardContainer: HBoxContainer = $Cards

func add_card(cardData: CardData):
	var card = Create.card(cardData)
	card.clicked.connect(select.bind(card))
	cardContainer.add_child(card)

func select(card: Card):
	choice.emit(card.data)

static func from(cards: Array[CardData]) -> CardData:
	var draft = preload("res://ui/draft.tscn").instantiate() as Draft
	Meta.add_child(draft)
	
	for cardData in cards:
		draft.add_card(cardData)
	
	var draftedCard = await draft.choice

	draft.queue_free()
	
	return draftedCard
