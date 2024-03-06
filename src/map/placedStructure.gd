class_name PlacedStructure
extends Node2D

var structurePreview: StructureView:
	get:
		return $StructureView

@export var structure: Structure:
	set(value):
		structurePreview.structure = value
	get:
		return structurePreview.structure

