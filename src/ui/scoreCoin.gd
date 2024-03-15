class_name ScoreCoin
extends Node2D



var val: int:
	set(value):
		if val == value:
			return
		val = value
		$Background/Text.text = "[center]+%d" % [val]
