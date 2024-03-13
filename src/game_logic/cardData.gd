class_name CardData
extends Resource

@export var name: String
@export var cells: Array[Vector2i]
@export var alignment: Alignment
@export var rules: RulesHooks

func _init(n: String):
	name = n
	
	alignment = [
		RedAlignment.new(),
		YellowAlignment.new(),
		BlueAlignment.new(),
		GreenAlignment.new(),
		OrangeAlignment.new(),
		PurpleAlignment.new()
		].pick_random()
	rules = alignment.get_rules() # TODO: This is placeholder until i decouple alignment and rules hooks

	var structure_name = standardStructures.keys().pick_random()
	cells.clear()
	cells.append_array(standardStructures[structure_name])

const standardStructures: Dictionary = {
	"unit": [Vector2i(0, 0)],
	"two": [Vector2i(0, 0), Vector2i(1, -1)],
	"tri": [Vector2i(0, 0), Vector2i(1, -1), Vector2i(1, 0)]
}
