
extends Node2D

signal toggled(new_state: bool)

@onready var uiRoot : CanvasLayer = $UI
@onready var toggleButton : CheckBox = $Toggle
@onready var messageFeed : MessageFeed = $UI/MessageFeed
@onready var versionLabel : RichTextLabel = $UI/Version

var enabled: bool:
	set(value):
		if value == enabled:
			return
		enabled = value
		toggled.emit(enabled)
		toggleButton.set_pressed(enabled)
		uiRoot.visible = enabled

func push_message(message: String):
	messageFeed.push(message)

func _ready() -> void:
	versionLabel.append_text("[center]Iteration: Stage 1")

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ALT:
		enabled = event.is_pressed()

func _on_check_button_toggled(toggled_on: bool) -> void:
	enabled = toggled_on
