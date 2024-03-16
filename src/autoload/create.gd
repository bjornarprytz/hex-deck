class_name Factory
extends Node2D

@onready var cardSpawner : PackedScene = preload("res://cards/card.tscn")


func card(data: CardData) -> Card:
	var cardScene = cardSpawner.instantiate() as Card
	cardScene.data = data
	return cardScene
