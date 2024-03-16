class_name Factory
extends Node2D

@onready var cardSpawner : PackedScene = preload("res://cards/card.tscn")


func card(data: CardData) -> Card:
	var card = cardSpawner.instantiate() as Card
	card.data = data
	return card
