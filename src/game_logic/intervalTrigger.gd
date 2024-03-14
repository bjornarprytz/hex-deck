class_name IntervalTrigger
extends Resource

var effects: Array[Effect]

func __init(triggerEffects: Array[Effect]):
	effects = triggerEffects

func tick(args: EffectArgs):
	var state = args.structure.state

	if state.counter == 0:
		for effect in effects:
			effect.resolve(args)
		state.counter = state.maxCounter
