class_name GameEffect
extends Resource

func resolve(_args: GameEffectArgs):
	push_error("resolve() should be overridden")

func rules_text() -> String:
	push_error("rules_text() should be overdidden")
	return "Error"
