class_name Card
extends Node2D

@onready var background: ColorRect = $Color

@onready var width : float = background.size.x

var structurePreview: StructureView:
	get:
		return $StructurePreview

var nameLabel: RichTextLabel:
	get:
		return $Name

var structure : Structure:
	get:
		return structurePreview.structure
	set(value):
		structurePreview.structure = value

@export var data : CardData:
	set(value):
		if data == value:
			return
		
		data = value
		structurePreview.structure = data.structure
		nameLabel.text = data.name
		

func cancel():
	Events.cardReleased.emit(self)

func _on_handle_pressed() -> void:
	Events.cardGrabbed.emit(self)
