class_name PileInfo
extends Control

@onready var summarySpawner: PackedScene = preload("res://ui/info/card_summary.tscn")
@onready var infoContainer: VBoxContainer = $VB

var cards: Array[CardData] = []:
	set(value):
		if value == cards:
			return
		cards = value
		_update()

func _update():
	for child in infoContainer.get_children():
		child.queue_free()

	for card in cards:
		var summary = summarySpawner.instantiate() as CardSummary
		infoContainer.add_child(summary)
		summary.cardData = card
