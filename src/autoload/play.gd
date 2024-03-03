class_name GameApi
extends Node

signal cardGrabbed(card: Card)
signal cardReleased(card: Card)
signal cardPlayed(card: Card, tile: Tile, orientation_degrees: int)
signal tileClicked(tile: Tile)
signal tileHovered(tile: Tile)

@onready var cardSpawner = preload("res://cards/card.tscn")
@onready var structureSpawner = preload("res://map/placed_structure.tscn")

func play_card(card: Card, map: Map, targetTile: Tile, rotationSteps: int):
	var rotatedStructure = card.data.structure.get_rotated(rotationSteps)
	var affectedTiles = rotatedStructure.get_affected_tiles(map, targetTile)
	var placedStructure = structureSpawner.instantiate() as PlacedStructure
	
	placedStructure.structure = rotatedStructure
	placedStructure.originTile = targetTile
	map.add_child(placedStructure)
	placedStructure.position = targetTile.position
	
	for tile in affectedTiles:
		tile.structure = placedStructure.structure

func draw_card(deck: Deck, hand: Hand):
	var cardData = deck.cards.pop_front()
	
	var card = cardSpawner.instantiate() as Card
	card.data = cardData
	card.global_position = deck.cardAnchor.global_position
	
	hand.add_card(card)

func discard_card(deck: Deck, hand: Hand, card: Card):
	print("TODO: Implement discard_card")
	pass
