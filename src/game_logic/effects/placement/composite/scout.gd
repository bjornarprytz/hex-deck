class_name Scout
extends Effect

var _effect: Effect = EachAdjacentTile.new(FoodForEmptyInTilePile.new())

func resolve(args: PlacementEffectArgs):
	await _effect.resolve(args)

func rules_text() -> String:
	return "Add food for each empty adjacent tile"

func keyword() -> String:
	return "Scout"
