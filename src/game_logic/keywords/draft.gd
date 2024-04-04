class_name Draft
extends Keyword

var _effect: DraftCards

func _init() -> void:
	_effect = DraftCards.new()

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_effect)

func short_hand() -> String:
	return "Draft"

func rules_text() -> String:
	return "Draft 1 of 3 random cards."
