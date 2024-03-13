class_name MutableState
extends Resource

var maxCounter: int:
    set(value):
        if value == maxCounter:
            return
        maxCounter = value
        
        emit_changed()

## Used for interval triggers
var counter: int:
    set(value):
        if value == counter:
            return
        counter = value
        
        emit_changed()

## Used for movement
@export_range(0, 5) var facing: int:
    set(value):
        while value < 0:
            value += 6
        value = value % 6
        if value == facing:
            return
        
        emit_changed()