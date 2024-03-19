class_name TradePrompt
extends Node2D

signal confirm(cardToDiscard: Card, effect: Effect)

var choice: Card

var hand : Hand:
	set(value):
		if (hand == value):
			return
		hand = value
		hand.cardClicked.connect(select)

var mandatory: bool:
	set(value):
		mandatory = value
		$Background/SkipButton.visible = !value

func select(card: Card):
	if choice != null:
		choice.selected = false
	choice = card
	choice.selected = true
	$Background/FoodButton.disabled = false
	$Background/GoldButton.disabled = false

func _on_food_button_pressed() -> void:
	confirm.emit(choice, AddFood.new(2))

func _on_gold_button_pressed() -> void:
	confirm.emit(choice, AddGold.new())

func _on_skip_button_pressed() -> void:
	confirm.emit(null, null)

func _exit_tree() -> void:
	if choice != null:
		choice.selected = false
