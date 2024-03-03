class_name Deck
extends Node2D

@onready var cards : Array[CardData] = [
	CardData.new("A", "tri"),
	CardData.new("B", "tri"),
	CardData.new("C", "tri"),
	CardData.new("D", "tri"),
	CardData.new("E", "tri"),
	CardData.new("F", "tri"),
	CardData.new("G", "tri"),
	CardData.new("H", "tri"),
	CardData.new("I", "tri"),
	CardData.new("J", "tri"),
	CardData.new("L", "tri"),
]

@onready var cardAnchor : Node2D = $Color/CardAnchor

func _ready() -> void:
	pass
