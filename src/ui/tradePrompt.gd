class_name TradePrompt
extends Node2D

signal confirm(cardToDiscard: Card, effect: Effect)

var choice: Card
var mandatory: bool:
	set(value):
		mandatory = value
		$SkipButton.visible = !value

func register_card(card: Card):
	card.clicked.connect(select.bind(card))

func select(card: Card):
	choice = card
	$FoodButton.disabled = false
	$GoldButton.disabled = false

func _on_food_button_pressed() -> void:
	confirm.emit(choice, AddFood.new(2))

func _on_gold_button_pressed() -> void:
	confirm.emit(choice, AddGold.new())

func _on_skip_button_pressed() -> void:
	confirm.emit(null, null)

static func from(options: Array[Card], isMandatory: bool=false) -> Array:
	var trade = preload ("res://ui/trade_prompt.tscn").instantiate() as TradePrompt
	Meta.add_child(trade)
	trade.mandatory = isMandatory

	for card in options:
		trade.register_card(card)

	var result = await trade.confirm

	trade.queue_free()

	return result
