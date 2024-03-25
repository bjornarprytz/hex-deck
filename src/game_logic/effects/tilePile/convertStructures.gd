class_name ConvertStructures
extends TilePileEffect

var from: Alignment.Id
var to: Alignment.Id

func _init(inputFrom: Alignment.Id, inputTo: Alignment.Id):
	from = inputFrom
	to = inputTo

func resolve(args: TilePileEffectArgs):
	var structures: Array[PlacedStructure] = []
	for tile in args.tiles:
		if tile.has_structure() and \
		tile.placedStructure.structure.alignment == from and \
		!structures.has(tile.placedStructure):
			structures.append(tile.placedStructure)

	for structure in structures:
		if structure.structure.alignment == from:
			structure.structure.alignment = to
	
	Events.onStructuresConverted.emit(self, args, structures)

func keyword() -> String:
	return "Convert %s to %s" % [Alignment.Id.values()[from],Alignment.Id.values()[to]]

func rules_text() -> String:
	return "Convert all structures of alignment %s to alignment %s " % [Alignment.Id.values()[from],Alignment.Id.values()[to]]
