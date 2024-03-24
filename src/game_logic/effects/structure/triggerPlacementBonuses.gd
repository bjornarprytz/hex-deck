class_name TriggerPlacementBonuses
extends Effect

func resolve(args: StructureEffectArgs):
	for tile in args.affectedTiles:
		if tile.placementBonus != null:
			for effect in tile.placementBonus.rules.placementEffects:
				await effect.resolve(args)

func rules_text() -> String:
	return "Re-trigger placement bonuses"

func keyword() -> String:
	return "Trigger Placement Bonuses"
