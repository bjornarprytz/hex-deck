class_name EnvelopForUniformity
extends Keyword

var _effect: Envelop
var _amount: int

func _init(x: int) -> void:
	_effect = Envelop.new(x, FoodForUniformityInTilePile.new())
	_amount = x

func register_effects(rulesHooks: RulesHooks) -> void:
	## TODO: Add placement effect to add the state to the structure. Also: Add SetState Effect
	rulesHooks.adjacentPlacementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.adjacentPlacementEffects.erase(_effect)

func short_hand() -> String:
	return "Envelop %d: Uniformity" % [_amount]

func rules_text() -> String:
	return "Once the structure is enveloped by %d tiles, gain 1 food per tile of the most common color in the envelopment." % [_effect.x]
