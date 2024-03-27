class_name Forage
extends Effect

var _effect: Effect = EachAffectedTile.new(FoodForPlacementBonusInTilePile.new())

func resolve(args: PlacementEffectArgs):
	await _effect.resolve(args)

func rules_text() -> String:
	return "Add food for each placement bonus"

func keyword() -> String:
	return "Forage"
