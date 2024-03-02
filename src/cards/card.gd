class_name Card
extends Area2D

@onready var background: ColorRect = $Color
@onready var width : float = background.size.x

@onready var structure: Structure

var color : Color:
	get:
		return structure.color
