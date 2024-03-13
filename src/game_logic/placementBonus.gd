class_name PlacementBonus
extends Resource

var rules: RulesHooks

func _init(placementEffects: Array[Effect]) -> void:
    rules = RulesHooks.new().with_placement_effects(placementEffects)