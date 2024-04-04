class_name Retain
extends Keyword

var _effect: RetainCards
var _amount: int

func _init(x: int=1):
	_effect = RetainCards.new(x)
	_amount = x

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_effect)

func short_hand() -> String:
	return "Retain %d" % [_amount]

func rules_text() -> String:
	return "Retain %d cards. Retained cards will not be discarded this turn" % [_amount]
