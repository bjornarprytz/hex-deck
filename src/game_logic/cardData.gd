class_name CardData
extends Resource

var name: String
var cells: Array[Vector2i]
var alignment: Alignment
var rules: RulesHooks

static func Random(cardName: String) -> CardData:
	var data = CardData.new()

	data.name = cardName

	data.alignment = [
		RedAlignment.new(),
		YellowAlignment.new(),
		BlueAlignment.new(),
		GreenAlignment.new(),
		OrangeAlignment.new(),
		PurpleAlignment.new()
		].pick_random()
	
	data.rules = standardRules[data.alignment.get_color()]

	data.cells.clear()
	data.cells.append_array(standardStructures.pick_random())

	return data

const standardStructures: Array = [
	[Vector2i(0, 0)],
	[Vector2i(0, 0), Vector2i(1, -1)],
	[Vector2i(0, 0), Vector2i(1, -1), Vector2i(1, 0)]
]

static var standardRules: Dictionary = {
	Color.YELLOW: RulesHooks.new().with_income_effects([AddFoodPerSimilarTile.new()]),
	Color.INDIAN_RED: RulesHooks.new().with_income_effects([AddFoodPerDifferentTile.new()]),
	Color.MEDIUM_PURPLE: RulesHooks.new().with_income_effects([AddGold.new()]),
	Color.DARK_ORANGE: RulesHooks.new().with_placement_rules([WaterAffinityRule.new()]).with_static_rules_text("Requires water"),
	Color.FOREST_GREEN: RulesHooks.new().with_income_effects([AddFood.new()]),
	Color.CADET_BLUE: RulesHooks.new().with_placement_effects([DrawCard.new()]),
}
