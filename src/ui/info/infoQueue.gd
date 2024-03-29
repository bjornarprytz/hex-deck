class_name InfoQueue
extends Node2D

@onready var messageSpawner: PackedScene = preload ("res://ui/info/message.tscn")
@onready var summarySpawner: PackedScene = preload ("res://ui/info/card_summary.tscn")

@onready var info: VBoxContainer = $VB/Info
@onready var clearButton: Button = $VB/Clear

func push_card_info(cardDatas: Array[CardData], header: String=""):
	if header != "":
		var message = messageSpawner.instantiate() as RichTextLabel
		info.add_child(message)
		message.text = header

	for cardData in cardDatas:
		var cardSummary = summarySpawner.instantiate() as CardSummary
		info.add_child(cardSummary)
		cardSummary.cardData = cardData
		cardSummary.clickToRemove = true

	clearButton.show()

func push_message(message: String):
	var messageControl = messageSpawner.instantiate() as RichTextLabel
	messageControl.text = message

	info.add_child(messageControl)
	clearButton.show()

func _on_clear_pressed() -> void:
	for item in info.get_children():
		item.queue_free()
	clearButton.hide()
