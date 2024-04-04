class_name EnvelopForUniformity
extends Keyword

var _initEffect: SetState = SetState.new("enveloped", 0)
var _effect: Envelop
var _amount: int

func _init(x: int) -> void:
	_effect = Envelop.new(x, FoodForUniformityInTilePile.new())
	_amount = x

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_initEffect)
	rulesHooks.adjacentPlacementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.adjacentPlacementEffects.erase(_effect)
	rulesHooks.placementEffects.erase(_initEffect)

func short_hand() -> String:
	return "Envelop %d: Uniformity" % [_amount]

func rules_text() -> String:
	return "Once the structure is enveloped by %d tiles, gain 1 food per tile of the most common color in the envelopment." % [_amount]
