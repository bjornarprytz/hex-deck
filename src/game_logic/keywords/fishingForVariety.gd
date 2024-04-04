class_name FishingForVariety
extends Keyword

var _fishingEffect: MillCards
var _amount: int

func _init(x: int):
	_fishingEffect = MillCards.new(x, FoodForVarietyInCardPile.new())
	_amount = x

func register_effects(rulesHooks: RulesHooks):
	rulesHooks.placementEffects.push_back(_fishingEffect)

func unregister_effects(rulesHooks: RulesHooks):
	rulesHooks.placementEffects.erase(_fishingEffect)

func short_hand():
	return "Fishing %d: Variety" % [_amount]
