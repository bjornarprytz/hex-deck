class_name ConvertAdjacent
extends Keyword

var _effect: EachAdjacentTile
var _from: Alignment.Id
var _to: Alignment.Id

func _init(from: Alignment.Id, to: Alignment.Id) -> void:
	_effect = EachAdjacentTile.new(ConvertStructures.new(from, to))
	_from = from
	_to = to

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_effect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_effect)

func short_hand() -> String:
	return "Convert Adjacent: %s -> %s" % [_from, _to]

func rules_text() -> String:
	return "Convert all adjacent %s to %s" % [_from, _to]
