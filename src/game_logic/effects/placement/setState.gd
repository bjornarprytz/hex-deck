class_name SetState
extends Effect

var _key: String
var _value: Variant

func _init(key: String, value: Variant):
    _key = key
    _value = value

func resolve(args: PlacementEffectArgs) -> void:
    var placedStructure = args.placedStructure

    placedStructure.mutableState.set_state(_key, _value)
