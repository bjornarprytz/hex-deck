class_name PlacementRule
extends Resource

func check(_args: PlayEffectArgs) -> String:
	push_error("check() should be overridden for this rule")
	return "Placeholder ErrorMessage for placement rule"

func rules_text():
	return ""
