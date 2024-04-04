class_name Card
extends Control

signal clicked(card: Card)

@onready var background: ColorRect = $Color
@onready var width: float = background.size.x
@onready var border: ReferenceRect = $Color/Border
@onready var baseBorderColor = border.border_color

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
		rulesText.text = Card.format_rules_text(data.keywords)

var state: CardState = CardState.new()

var cost: CardData.Cost:
	get:
		return data.cost

var selected: bool:
	set(value):
		selected = value
		
		if (selected):
			border.border_color = Color.CORAL
		else:
			border.border_color = baseBorderColor

func _on_handle_pressed() -> void:
	clicked.emit(self)

static func format_rules_text(keywords: Array) -> String:
	var text = "[center]"
	for keyword in keywords:
		text += "%s\n" % [keyword.short_hand()]
	return text
