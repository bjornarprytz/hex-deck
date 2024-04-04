class_name ConnectedForUniformity
extends Keyword

var _connectionEffect: EachConnectedTile = EachConnectedTile.new(FoodForUniformityInTilePile.new())

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_connectionEffect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_connectionEffect)

func short_hand() -> String:
	return "Connected: Uniformity"

func rules_text() -> String:
	return "Gain 1 food for each connected tile with the same alignment."
