class_name BuyPrompt
extends Node2D

signal confirm(effects: Array[Effect])

func _on_food_button_pressed() -> void:
	confirm.emit([PayGold.new(1), AddFood.new(1)])

func _on_gold_button_pressed() -> void:
	confirm.emit([PayFood.new(1), AddGold.new(1)])

func _on_skip_button_pressed() -> void:
	confirm.emit([])

static func ask() -> Array[Effect]:
	var prompt = preload ("res://ui/buy_prompt.tscn").instantiate() as BuyPrompt
	Meta.add_child(prompt)

	var effects = await prompt.confirm

	prompt.queue_free()

	return effects
