class_name Factory
extends Node2D

@onready var cardSpawner: PackedScene = preload ("res://cards/card.tscn")
@onready var structureSpawner: PackedScene = preload ("res://map/placed_structure.tscn")

func card(data: CardData) -> Card:
	var cardScene = cardSpawner.instantiate() as Card
	cardScene.data = data
	return cardScene

func placedStructure(structure: Structure) -> PlacedStructure:
	var placedStructureScene = structureSpawner.instantiate() as PlacedStructure
	placedStructureScene.structure = structure
	return placedStructureScene
