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

func _ready() -> void:
	pass
