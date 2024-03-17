class_name Card
extends Control

signal clicked

@onready var background: ColorRect = $Color
@onready var width: float = background.size.x

var structurePreview: StructureView:
	get:
		return $StructurePreview

var rulesText: RichTextLabel:
	get:
		return $RulesText

var cardName: RichTextLabel:
	get:
		return $Name

var goldCost: RichTextLabel:
	get:
		return $GoldCost

var foodCost: RichTextLabel:
	get:
		return $FoodCost

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
		cardName.text = "[u]%s" % [data.name]
		goldCost.text = "[center]%s" % [data.cost.gold]
		foodCost.text = "[center]%s" % [data.cost.food]
		structurePreview.structure = Structure.new(data.alignment, data.cells, data.rules)
		rulesText.text = structurePreview.structure.get_rules().rules_text()

var cost: CardData.Cost:
	get:
		return data.cost

func cancel():
	Events.cardReleased.emit(self)

func _on_handle_pressed() -> void:
	clicked.emit()
	Events.cardGrabbed.emit(self)
