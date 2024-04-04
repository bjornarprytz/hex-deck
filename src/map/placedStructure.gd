class_name PlacedStructure
extends Node2D

var structureView: StructureView:
	get:
		return $StructureView

var structure: Structure:
	set(value):
		structureView.structure = value
	get:
		return structureView.structure

var affectedTiles: Array[Tile]
var mutableState: MutableState = MutableState.new()

func _ready() -> void:
	mutableState.changed.connect(_update_enveloped)

func _update_enveloped():
	var enveloped = mutableState.get_state("enveloped")

	if enveloped != null:
		$Info.text = "%d" % [enveloped]

func get_adjacent_tiles() -> Array[Tile]:
	var adjacent_tiles: Array[Tile] = []

	for tile in affectedTiles:
		for n in tile.get_neighbours():
			if !adjacent_tiles.has(n) and !affectedTiles.has(n):
				adjacent_tiles.push_back(n)

	return adjacent_tiles

## This method does not take facing into account
func move_along_path(rotatedPath: Array[Vector2i]):
	# Clear current position
	for tile in affectedTiles:
		tile.placedStructure = null
	var currentAffectedTiles = affectedTiles

	var targetTile = currentAffectedTiles[0]
	# Walk along the path
	for step in rotatedPath:
		# Check the placement TODO: Maybe this should be unified under the placement rules or something
		targetTile = targetTile.get_relative_tile(step)
		if targetTile == null:
			break

		var newAffectedTiles = structure.get_affected_tiles(targetTile)
		if newAffectedTiles.size() < structure.cells.size():
			break

		var obstructed: bool = false
		for tile in newAffectedTiles:
			if tile.has_structure() or tile.type == TileInfo.TerrainType.Water or tile.type == TileInfo.TerrainType.Mountain:
				obstructed = true
		if obstructed:
			break

		# Move to the new placement
		currentAffectedTiles = newAffectedTiles
		await create_tween().tween_property(self, 'position', targetTile.position, .1).finished

	affectedTiles = currentAffectedTiles
	for tile in affectedTiles:
		tile.placedStructure = self
