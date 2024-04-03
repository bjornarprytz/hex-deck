class_name Keyword
extends Resource

func register_effects(_rulesHooks: RulesHooks) -> void:
    push_error("register_effects() not implemented")

func unregister_effects(_rulesHooks: RulesHooks) -> void:
    push_error("unregister_effects() not implemented")

func short_hand() -> String:
    push_error("short_hand() not implemented")
    return ""

func rules_text() -> String:
    push_warning("rules_text() not implemented")
    return ""