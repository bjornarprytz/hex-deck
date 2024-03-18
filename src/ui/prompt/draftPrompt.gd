class_name DraftPrompt
extends Node2D

signal choice(cardData: CardData)

@onready var cardContainer: HBoxContainer = $Cards

func add_card(cardData: CardData):
	var card = Create.card(cardData)
	card.clicked.connect(select.bind(card))
	cardContainer.add_child(card)

func select(card: Card):
	choice.emit(card.data)
