class_name MessageFeed
extends VBoxContainer

@onready var messageSpawner = preload("res://ui/message.tscn")

func push(message: String):
	var m = messageSpawner.instantiate() as RichTextLabel
	
	m.text = message
	add_child(m)
	await get_tree().create_timer(4.0).timeout
	m.queue_free()
