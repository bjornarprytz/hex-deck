class_name MessageFeed
extends VBoxContainer

@onready var messageSpawner = preload ("res://ui/info/message.tscn")

func push(message: String):
	var m = messageSpawner.instantiate() as RichTextLabel
	
	m.text = message
	add_child(m)
	m.modulate = Color.PALE_VIOLET_RED
	var tween = create_tween()
	tween.tween_property(m, 'modulate', Color.WHITE, 10.0)
	tween.tween_callback(m.queue_free)
