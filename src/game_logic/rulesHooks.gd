class_name RulesHooks
extends Resource

var _rulesText: String = ""

## Rules that restrict the placement of a structure
var placementRules: Array[PlacementRule] = []
## Effects that trigger when the structure is placed on the map
var placementEffects: Array[Effect] = []
## Effects that trigger during cleanup (after each hand)
var incomeEffects: Array[Effect] = []
## Effects that trigger on specific events ({eventName: Array[Effects]})
var triggeredEffects: Dictionary

func rules_text() -> String:
	var placementText = ""
	var incomeText = ""

	if (_rulesText == ""):
		for effect in placementEffects:
			var text = effect.rules_text()
			if placementText == "":
				placementText = "Immediate: %s" % [text]
			else:
				placementText = "%s %s" % [placementText, text]
		
		for effect in incomeEffects:
			var text = effect.rules_text()
			if incomeText == "":
				incomeText = "Income: %s" % [text]
			else:
				incomeText = "%s %s" % [incomeText, text]
	
	for part in [placementText, incomeText]:
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

func with_income_effects(effects: Array[Effect]) -> RulesHooks:
	incomeEffects.append_array(effects)
	return self

func with_static_rules_text(text: String) -> RulesHooks:
	_rulesText = text
	return self