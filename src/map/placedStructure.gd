class_name PlacedStructure
extends Node2D

var structureView: StructureView:
	get:
		return $StructureView

@export var structure: Structure:
	set(value):
		structureView.structure = value
	get:
		return structureView.structure

var affectedTiles: Array[Tile]

func get_adjacent_tiles() -> Array[Tile]:
	var adjacent_tiles: Array[Tile] = []

	for tile in affectedTiles:
		for n in tile.get_neighbours():
			if !adjacent_tiles.has(n) and !affectedTiles.has(n):
				adjacent_tiles.push_back(n)

	return adjacent_tiles
