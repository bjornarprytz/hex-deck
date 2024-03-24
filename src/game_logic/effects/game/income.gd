class_name Income
extends Effect

func resolve(args: EffectArgs):
	var map = args.gameState.map

	Events.onBeforeIncome.emit(args)

	for placedStructure in map.get_placed_structures():
		var structureEffectArgs = StructureEffectArgs.new(args.gameState, placedStructure)
		for effect in placedStructure.structure.get_rules().incomeEffects:
			await effect.resolve(structureEffectArgs)
	
	Events.onAfterIncome.emit(args)

func rules_text() -> String:
	return "Trigger income effects in placed structures"

func keyword() -> String:
	return "Income Phase"