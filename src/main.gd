extends Node2D

@onready var card_spawner = preload("res://cards/card.tscn")
@onready var hand : Hand = $Hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand.add_card(card_spawner.instantiate())
	hand.add_card(card_spawner.instantiate())
	hand.add_card(card_spawner.instantiate())
	hand.add_card(card_spawner.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
