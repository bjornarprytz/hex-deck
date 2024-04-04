class_name Scout
extends Keyword

var _scoutEffect: EachAdjacentTile = EachAdjacentTile.new(FoodForEmptyInTilePile.new())

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_scoutEffect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_scoutEffect)

func short_hand() -> String:
	return "Scout"

func rules_text() -> String:
	return "Gain 1 food for each empty tile adjacent to this tile."
