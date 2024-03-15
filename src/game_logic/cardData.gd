class_name CardData
extends Resource

class Cost:
	var food: int
	var gold: int

var name: String
var cost: Cost = Cost.new()
var cells: Array[Vector2i]
var alignment: Alignment.Id
var rules: RulesHooks

func with_special_rules(specialRules: RulesHooks) -> CardData:
	rules = specialRules
	return self

func with_food_cost(amount: int) -> CardData:
	cost.food = amount
	return self

func with_gold_cost(amount: int) -> CardData:
	cost.gold = amount
	return self

static func Random(cardName: String) -> CardData:
	var data = CardData.new()

	data.name = cardName

	data.alignment = Alignment.Id.values().pick_random()
	
	data.rules = RulesHooks.new() # No special rules

	data.cells.clear()
	data.cells.append_array(standardStructures.pick_random())

	return data

static func Create(size: int, inputAlignment: Alignment.Id, specialRules: RulesHooks=RulesHooks.new()):
	size = size - 1 # Make it zero-based
	assert(size >= 0 and size <= 4)
	var data = CardData.new()
	data.name = "Placeholder"
	data.alignment = inputAlignment
	data.cells = standardStructures[size]
	data.rules = specialRules
	return data

static var standardStructures: Array = [
	Utils.get_cells(),
	Utils.get_cells([[1, -1]]),
	Utils.get_cells([[1, -1], [1, 0]]),
	Utils.get_cells([[1, -1], [1, 0], [0, -1]]),
	Utils.get_cells([[1, -1], [1, 0], [0, -1], [0, 1]]),
]
