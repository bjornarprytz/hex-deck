class_name Card
extends Node2D

@onready var background: ColorRect = $Color
@onready var structurePreview: StructurePreview = $StructurePreview
@onready var width : float = background.size.x

@export var data : CardData

func _ready() -> void:
	background.color = data.structure.color
	structurePreview.structure = data.structure

func cancel():
	Play.cardReleased.emit(self)

func _on_handle_pressed() -> void:
	Play.cardGrabbed.emit(self)
