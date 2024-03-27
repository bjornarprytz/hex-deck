class_name RulesHooks
extends Resource

var _rulesText: String = ""

## Rules that restrict the placement of a structure
var placementRules: Array[PlacementRule] = []
## Effects that trigger when the structure is placed on the map
var placementEffects: Array[Effect] = []
## Effects that trigger during cleanup (after each hand)
var incomeEffects: Array[Effect] = []
## Effects that trigger when a structure is placed adjacent to this one
var adjacentPlacementEffects: Array[Effect] = []
## Effects that trigger after a card is played
var cardPlayEffects: Array[Effect] = []

## Effects that trigger on specific events ({eventName: Array[Effects]})
var triggeredEffects: Dictionary

func rules_text() -> String:
	var placementRulesText = ""
	var placementEffectsText = ""
	var adjacentPlacementEffectsText = ""
	var incomeText = ""
	var cardPlayText = ""

	if (_rulesText == ""):
		for rule in placementRules:
			var text = rule.keyword()
			placementRulesText = "%s\n%s" % [placementRulesText, text]

		for effect in placementEffects:
			var text = effect.keyword()
			placementEffectsText = "%s\n%s" % [placementEffectsText, text]
		
		for effect in adjacentPlacementEffects:
			var text = effect.keyword()
			adjacentPlacementEffectsText = "%s\n%s" % [adjacentPlacementEffectsText, text]

		for effect in incomeEffects:
			var text = effect.keyword()
			incomeText = "%s\n%s" % [incomeText, text]
		
		for effect in cardPlayEffects:
			var text = effect.keyword()
			cardPlayText = "%s\n%s" % [cardPlayText, text]
	
	for part in [placementRulesText, placementEffectsText, adjacentPlacementEffectsText, incomeText, cardPlayText]:
		if part != "":
			if _rulesText != "":
				_rulesText += "\n"

			_rulesText = "%s%s" % [_rulesText, part]

	return _rulesText

func with_placement_rules(rules: Array[PlacementRule]) -> RulesHooks:
	placementRules.append_array(rules)
	return self

func with_placement_effects(effects: Array[Effect]) -> RulesHooks:
	placementEffects.append_array(effects)
	return self

func with_adjacent_placement_effects(effects: Array[Effect]) -> RulesHooks:
	adjacentPlacementEffects.append_array(effects)
	return self

func with_income_effects(effects: Array[Effect]) -> RulesHooks:
	incomeEffects.append_array(effects)
	return self

func with_card_play_effects(effects: Array[Effect]) -> RulesHooks:
	cardPlayEffects.append_array(effects)
	return self

func merge(other: RulesHooks) -> RulesHooks:
	return RulesHooks.new() \
		.with_placement_rules(placementRules) \
		.with_placement_rules(other.placementRules) \

		.with_placement_effects(placementEffects) \
		.with_placement_effects(other.placementEffects) \

		.with_adjacent_placement_effects(adjacentPlacementEffects) \
		.with_adjacent_placement_effects(other.adjacentPlacementEffects) \

		.with_income_effects(incomeEffects) \
		.with_income_effects(other.incomeEffects) \

		.with_card_play_effects(cardPlayEffects) \
		.with_card_play_effects(other.cardPlayEffects)
