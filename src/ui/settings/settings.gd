class_name GameSettingsHolder
extends Node2D

func _on_play_pressed() -> void:
	Meta.reset()
	get_tree().change_scene_to_file("res://main.tscn")
