class_name Wild
extends Keyword

var _effect: PickStructureColor = PickStructureColor.new()

func register_effects(rulesHooks: RulesHooks):
	rulesHooks.placementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks):
	rulesHooks.placementEffects.erase(_effect)

func short_hand():
	return "Wild"
