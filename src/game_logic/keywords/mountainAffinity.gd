class_name MountainAffinity
extends Keyword

var _adjacentAffinityRule: AdjacentAffinityRule = AdjacentAffinityRule.new(TileInfo.TerrainType.Mountain)

func register_effects(rulesHooks: RulesHooks) -> void:
    rulesHooks.placementRules.push_back(_adjacentAffinityRule)

func unregister_effects(rulesHooks: RulesHooks) -> void:
    rulesHooks.placementRules.erase(_adjacentAffinityRule)

func short_hand() -> String:
    return "Mountain affinity"