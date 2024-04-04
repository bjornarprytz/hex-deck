class_name Draw
extends Keyword

var _effect: DrawCards
var amount: int

func _init(x: int=1) -> void:
	_effect = DrawCards.new(x)
	amount = x

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_effect)

func short_hand() -> String:
	return "Draw %d" % _effect.amount

func rules_text() -> String:
	return "Draft 1 of 3 random cards."
