class_name Forage
extends Keyword

var _forageEffect: Effect = EachAffectedTile.new(FoodForPlacementBonusInTilePile.new())

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_forageEffect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_forageEffect)

func short_hand() -> String:
	return "Forage"

func rules_text() -> String:
	return "Gain 1 food per placement bonus"
