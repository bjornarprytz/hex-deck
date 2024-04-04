class_name MutableState
extends Resource

var _flags: Dictionary = {}

func has_flag(flag: String) -> bool:
	return _flags.has(flag) and _flags[flag]

func set_flag(flag: String, value: bool=true) -> void:
	if _flags.has(flag) and _flags[flag] == value:
		return

	_flags[flag] = value
	emit_changed()

func set_state(key: String, value: Variant) -> void:
	if _flags.has(key) and _flags[key] == value:
		return
	
	_flags[key] = value
	emit_changed()

func get_state(key: String) -> Variant:
	return _flags[key]

func clear_state(key: String) -> void:
	if !_flags.has(key):
		return

	_flags.erase(key)
	emit_changed()

func clear() -> void:
	if _flags.is_empty():
		return

	_flags.clear()
	emit_changed()
