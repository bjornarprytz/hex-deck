class_name CardSummary
extends Control

@onready var nameLabel: RichTextLabel = $HB/Name
@onready var goldCost: RichTextLabel = $HB/GoldCost
@onready var foodCost: RichTextLabel = $HB/FoodCost
@onready var structureView: StructureView = $HB/Container/StructureView

var cardData: CardData:
	set(value):
		cardData = value
		nameLabel.text = cardData.name
		goldCost.text = str(cardData.cost.gold)
		foodCost.text = str(cardData.cost.food)
		structureView.structure = Structure.new(cardData.alignment, cardData.cells, cardData.rules)
