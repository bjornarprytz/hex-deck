class_name Trade
extends Keyword

var _tradeEffect: TradeCards

func _init() -> void:
	_tradeEffect = TradeCards.new()

func register_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.push_back(_tradeEffect)

func unregister_effects(rulesHooks: RulesHooks) -> void:
	rulesHooks.placementEffects.erase(_tradeEffect)

func short_hand() -> String:
	return "Trade"

func rules_text() -> String:
	return "May banish 1 card for either 2 food or 1 gold"
