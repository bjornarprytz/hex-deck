class_name PlaceStructure
extends Effect

func resolve(args: PlayEffectArgs):
	var map = args.gameState.map

	var placedStructure = map.place_structure(args.rotatedStructure, args.affectedTiles)

	var structureEffectArgs = StructureEffectArgs.new(args.gameState, placedStructure)

	for effect in args.rotatedStructure.get_rules().placementEffects:
		effect.resolve(structureEffectArgs)
	for tile in args.affectedTiles:
		if (tile.placementBonus == null):
			continue
		for effect in tile.placementBonus.rules.placementEffects:
			effect.resolve(structureEffectArgs)
	
	Events.onStructurePlaced.emit(structureEffectArgs)
