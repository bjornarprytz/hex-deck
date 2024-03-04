class_name Card
extends Node2D

@onready var background: ColorRect = $Color

@onready var width : float = background.size.x

var structurePreview: StructurePreview:
	get:
		return $StructurePreview

@export var data : CardData:
	set(value):
		if data == value:
			return
		
		data = value
		$StructurePreview.structure = data.structure
		

func cancel():
	Play.cardReleased.emit(self)

func _on_handle_pressed() -> void:
	Play.cardGrabbed.emit(self)
