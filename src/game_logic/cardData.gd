class_name CardData
extends Resource

@export var name : String
@export var structure : Structure

func _init(n: String):
	name = n
	structure = Structure.new()
	
	
	var structure_name = standardStructures.keys().pick_random()
	
	structure.alignment = Structure.Alignment.values().pick_random()
	structure.cells.clear()
	structure.cells.append_array(standardStructures[structure_name])



const standardStructures: Dictionary = {
	"unit": [Vector2i(0,0)],
	"two": [Vector2i(0,0), Vector2i(1,-1)],
	"tri": [Vector2i(0,0), Vector2i(1,-1), Vector2i(1,0)]
}
