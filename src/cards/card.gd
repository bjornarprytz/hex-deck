class_name Card
extends Node2D

@onready var background: ColorRect = $Color

@onready var width: float = background.size.x

var structurePreview: StructureView:
	get:
		return $StructurePreview

var rulesText: RichTextLabel:
	get:
		return $RulesText

var structure: Structure:
	get:
		return structurePreview.structure
	set(value):
		structurePreview.structure = value

var data: CardData:
	set(value):
		if data == value:
			return
		
		data = value
		structurePreview.structure = Structure.new(data.alignment, data.cells, data.rules)
		rulesText.text = structurePreview.structure.get_rules().rules_text()

var cost: CardData.Cost:
	get:
		return data.cost

func cancel():
	Events.cardReleased.emit(self)

func _on_handle_pressed() -> void:
	Events.cardGrabbed.emit(self)
