class_name PickStructureColor
extends Effect

func resolve(args: PlacementEffectArgs):
	var newAlignment = await Prompt.pick_color()

	args.placedStructure.structure.alignment = newAlignment
	
	Events.onStructuresConverted.emit(self, args, [args.placedStructure])
