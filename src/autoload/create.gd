class_name Factory
extends Node2D

@onready var cardSpawner: PackedScene = preload ("res://cards/card.tscn")
@onready var structureSpawner: PackedScene = preload ("res://map/placed_structure.tscn")
@onready var tileSpawner: PackedScene = preload ("res://map/tile.tscn")

func card(data: CardData) -> Card:
	var cardScene = cardSpawner.instantiate() as Card
	cardScene.data = data
	return cardScene

func placedStructure(structure: Structure) -> PlacedStructure:
	var placedStructureScene = structureSpawner.instantiate() as PlacedStructure
	placedStructureScene.structure = structure
	return placedStructureScene

func tile(tileInfo: TileInfo) -> Tile:
	var tileScene = tileSpawner.instantiate() as Tile

	tileScene.type = tileInfo.terrainType
	tileScene.placementBonus = tileInfo.placementBonus

	return tileScene
