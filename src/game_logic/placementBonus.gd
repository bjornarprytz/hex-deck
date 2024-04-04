class_name PlacementBonus
extends Resource

var rules: RulesHooks = RulesHooks.new()
var _keywords: Array[Keyword] = []

func _init(keywords: Array[Keyword]) -> void:
	_keywords = keywords

	for keyword in _keywords:
		keyword.register_effects(rules)

func rules_text() -> String:
	var text = ""

	for keyword in _keywords:
		text += keyword.short_hand() + "\n"

	return text
