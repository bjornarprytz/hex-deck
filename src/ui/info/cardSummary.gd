class_name CardSummary
extends Control

@onready var nameLabel: RichTextLabel = $HB/Name
@onready var goldCost: RichTextLabel = $HB/GoldCost
@onready var foodCost: RichTextLabel = $HB/FoodCost
@onready var structureView: StructureView = $HB/Container/StructureView

var clickToRemove: bool

var cardData: CardData:
	set(value):
		cardData = value
		nameLabel.text = cardData.name
		goldCost.text = "[center] %s" % str(cardData.cost.gold)
		foodCost.text = "[center] %s" % str(cardData.cost.food)
		structureView.structure = Structure.new(cardData.alignment, cardData.cells, cardData.rules)

func _gui_input(event: InputEvent) -> void:
	if clickToRemove and event is InputEventMouseButton:
		if event.pressed:
			queue_free()
