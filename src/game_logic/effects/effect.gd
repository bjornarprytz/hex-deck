class_name Effect
extends Resource

func resolve(_args):
	push_error("resolve() should be overridden")

func rules_text() -> String:
	push_error("rules_text() should be overdidden")
	return "Error"

func keyword() -> String:
	push_error("keyword() should be overdidden")
	return "Error"
