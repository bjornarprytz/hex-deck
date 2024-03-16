class_name RulesHooks
extends Resource

var _rulesText: String = ""

## Rules that restrict the placement of a structure
var placementRules: Array[PlacementRule] = []
## Effects that trigger when the structure is placed on the map
var placementEffects: Array[StructureEffect] = []
## Effects that trigger during cleanup (after each hand)
var incomeEffects: Array[StructureEffect] = []
## Effects that trigger after a card is played
var cardPlayEffects: Array[StructureEffect] = []

## Effects that trigger on specific events ({eventName: Array[Effects]})
var triggeredEffects: Dictionary

func rules_text() -> String:
	var placementRulesText = ""
	var placementEffectsText = ""
	var incomeText = ""
	var cardPlayText = ""

	if (_rulesText == ""):
		for rule in placementRules:
			var text = rule.rules_text()
			if placementRulesText == "":
				placementRulesText = "Restrictions: %s" % [text]
			else:
				placementRulesText = "%s %s" % [placementRulesText, text]

		for effect in placementEffects:
			var text = effect.rules_text()
			if placementEffectsText == "":
				placementEffectsText = "Immediate: %s" % [text]
			else:
				placementEffectsText = "%s %s" % [placementEffectsText, text]
		
		for effect in incomeEffects:
			var text = effect.rules_text()
			if incomeText == "":
				incomeText = "Income: %s" % [text]
			else:
				incomeText = "%s %s" % [incomeText, text]
		
		for effect in cardPlayEffects:
			var text = effect.rules_text()
			if cardPlayText == "":
				cardPlayText = "When a card i played: %s" % [text]
			else:
				cardPlayText = "%s %s" % [cardPlayText, text]
	
	for part in [placementRulesText, placementEffectsText, incomeText, cardPlayText]:
		if part != "":
			if _rulesText != "":
				_rulesText += "\n"

			_rulesText = "%s%s" % [_rulesText, part]

	return _rulesText

func with_placement_rules(rules: Array[PlacementRule]) -> RulesHooks:
	placementRules.append_array(rules)
	return self

func with_placement_effects(effects: Array[StructureEffect]) -> RulesHooks:
	placementEffects.append_array(effects)
	return self

func with_income_effects(effects: Array[StructureEffect]) -> RulesHooks:
	incomeEffects.append_array(effects)
	return self

func with_card_play_effects(effects: Array[StructureEffect]) -> RulesHooks:
	cardPlayEffects.append_array(effects)
	return self

func merge(other: RulesHooks) -> RulesHooks:
	return RulesHooks.new() \
		.with_placement_rules(placementRules) \
		.with_placement_rules(other.placementRules) \

		.with_placement_effects(placementEffects) \
		.with_placement_effects(other.placementEffects) \

		.with_income_effects(incomeEffects) \
		.with_income_effects(other.incomeEffects) \

		.with_card_play_effects(cardPlayEffects) \
		.with_card_play_effects(other.cardPlayEffects)
