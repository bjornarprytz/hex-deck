class_name PickColorPrompt
extends Node2D

signal choice(alignment: Alignment.Id)

func _on_red_pressed() -> void:
	choice.emit(Alignment.Id.Red)

func _on_blue_pressed() -> void:
	choice.emit(Alignment.Id.Blue)

func _on_yellow_pressed() -> void:
	choice.emit(Alignment.Id.Yellow)

func _on_green_pressed() -> void:
	choice.emit(Alignment.Id.Green)

func _on_orange_pressed() -> void:
	choice.emit(Alignment.Id.Orange)

func _on_purple_pressed() -> void:
	choice.emit(Alignment.Id.Purple)
