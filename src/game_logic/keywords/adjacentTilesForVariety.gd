class_name AdjacentTilesForVariety
extends Keyword

var _effect: EachAdjacentTile = EachAdjacentTile.new(FoodForVarietyInTilePile.new())

func register_effects(rulesHooks: RulesHooks):
	rulesHooks.placementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks):
	rulesHooks.placementEffects.erase(_effect)

func short_hand():
	return "Adjacent: Variety"

func rules_text():
	return "Gain 1 Food for each unique color in adjacent tiles."