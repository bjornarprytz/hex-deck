class_name CardState
extends Resource

var _flags: Dictionary = {}

func has_flag(flag: String) -> bool:
    return _flags.has(flag) and _flags[flag]

func set_flag(flag: String, value: bool=true) -> void:
    _flags[flag] = value
