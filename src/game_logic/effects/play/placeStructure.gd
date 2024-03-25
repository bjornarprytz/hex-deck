class_name PlaceStructure
extends Effect

func resolve(args: PlayEffectArgs):
	var map = args.gameState.map

	var placedStructure = map.place_structure(args.rotatedStructure, args.affectedTiles)

	var structureEffectArgs = PlacementEffectArgs.new(args.gameState, placedStructure)

	for effect in args.rotatedStructure.get_rules().placementEffects:
		await effect.resolve(structureEffectArgs)
	for tile in args.affectedTiles:
		if !tile.has_placement_bonus():
			continue
		for effect in tile.placementBonus.rules.placementEffects:
			await effect.resolve(structureEffectArgs)
	
	var adjacentStructures: Array[PlacedStructure] = []

	for tile in args.adjacentTiles:
		if (tile.has_structure() and !adjacentStructures.has(tile.placedStructure)):
			adjacentStructures.append(tile.placedStructure)
	
	for adjacentStructure in adjacentStructures:
		for effect in adjacentStructure.structure.get_rules().adjacentPlacementEffects:
			await effect.resolve(AdjacentPlacementEffectArgs.new(args.gameState, adjacentStructure, placedStructure))
	
	Events.onStructurePlaced.emit(structureEffectArgs)

func keyword() -> String:
	return "Place Structure"
