class_name Gold
extends Keyword

var _effect: AddGold
var _amount: int

func _init(x: int=1):
	_effect = AddGold.new(x)
	_amount = x

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_effect)

func short_hand() -> String:
	return "Gold %d" % [_amount]

func rules_text() -> String:
	return "Gain %d gold" % [_amount]
