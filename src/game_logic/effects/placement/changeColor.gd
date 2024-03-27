class_name ChangeColor
extends Effect

func resolve(args: PlacementEffectArgs):
	var newAlignment = await Prompt.pick_color()

	args.placedStructure.structure.alignment = newAlignment
	
	Events.onStructuresConverted.emit(self, args, [args.placedStructure])

func rules_text() -> String:
	return "Change the color of this structure"

func keyword() -> String:
	return "Wild"
