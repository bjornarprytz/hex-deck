class_name CardData
extends Resource

var name: String
var cells: Array[Vector2i]
var alignment: Alignment.Id
var rules: RulesHooks

static func Random(cardName: String) -> CardData:
	var data = CardData.new()

	data.name = cardName

	data.alignment = Alignment.Id.values().pick_random()
	
	data.rules = RulesHooks.new() # No special rules

	data.cells.clear()
	data.cells.append_array(standardStructures.pick_random())

	return data

const standardStructures: Array = [
	[Vector2i(0, 0)],
	[Vector2i(0, 0), Vector2i(1, -1)],
	[Vector2i(0, 0), Vector2i(1, -1), Vector2i(1, 0)]
]
