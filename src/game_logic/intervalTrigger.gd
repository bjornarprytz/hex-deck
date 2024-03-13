class_name IntervalTrigger
extends Resource

var maxCount : int
var counter : int
var _effects : Array[Effect]

func __init(inputMaxCount: int, triggerEffects: Array[Effect]):
	maxCount = inputMaxCount
	counter = maxCount
	_effects = triggerEffects

func tick(args: PlayArgs):
	counter -= 1

	if counter == 0:
		for effect in _effects:
			effect.resolve(args)
		counter = maxCount
	
