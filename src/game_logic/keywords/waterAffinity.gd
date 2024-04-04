class_name WaterAffinity
extends Keyword

var _adjacentAffinityRule: AdjacentAffinityRule = AdjacentAffinityRule.new(TileInfo.TerrainType.Water)

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementRules.push_back(_adjacentAffinityRule)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementRules.erase(_adjacentAffinityRule)

func short_hand() -> String:
	return "Water affinity"

func rules_text() -> String:
	return "Must be placed adjacent to a water tile."
