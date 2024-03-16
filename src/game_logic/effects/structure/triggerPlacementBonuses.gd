class_name TriggerPlacementBonuses
extends StructureEffect

func resolve(args: StructureEffectArgs):
	for tile in args.affectedTiles:
		if tile.placementBonus != null:
			for effect in tile.placementBonus.rules.placementEffects:
				effect.resolve(args)

func rules_text() -> String:
	return "Re-trigger placement bonuses"
