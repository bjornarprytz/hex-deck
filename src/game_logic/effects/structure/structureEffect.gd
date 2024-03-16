class_name StructureEffect
extends Resource

func resolve(_args: StructureEffectArgs):
	push_error("resolve() should be overridden")

func rules_text() -> String:
	push_error("rules_text() should be overdidden")
	return "Error"
