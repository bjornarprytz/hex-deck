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

static func Create(cardName: String, structureCells: Array[Vector2i], inputAlignment: Alignment.Id, specialRules: RulesHooks=RulesHooks.new()):
	var data = CardData.new()
	data.name = cardName
	data.alignment = inputAlignment
	data.cells = structureCells
	data.rules = specialRules
	return data
