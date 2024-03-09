class_name PlacementRule
extends Node

func check(_args: PlacementArgs) -> String:
	push_error("check() should be overridden for this rule")
	return "Placeholder ErrorMessage for placement rule"
