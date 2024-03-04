class_name GameApi
extends Node

signal cardGrabbed(card: Card)
signal cardReleased(card: Card)
signal cardPlayed(card: Card, tile: Tile, orientation_degrees: int)
signal tileClicked(tile: Tile)
signal tileHovered(tile: Tile)
signal gameOver(victory: bool)
signal scoreChanged(oldValue: int, newValue: int)
signal goldChanged(oldValue: int, newValue: int)

@onready var cardSpawner = preload("res://cards/card.tscn")
@onready var structureSpawner = preload("res://map/placed_structure.tscn")

var gold : int:
	get:
		return gold
	set(value):
		if (value == gold):
			return
		var oldValue = gold
		gold = value
		goldChanged.emit(oldValue, gold)
	

var score : int:
	get:
		return score
	set(value):
		if (value == score):
			return
		var oldValue = score
		score = value
		scoreChanged.emit(oldValue, score)
		

func play_card(card: Card, map: Map, targetTile: Tile, deck: Deck, hand : Hand, rotationSteps: int):
	var rotatedStructure = card.data.structure.get_rotated(rotationSteps)
	var affectedTiles = rotatedStructure.get_affected_tiles(map, targetTile)
	var placedStructure = structureSpawner.instantiate() as PlacedStructure
	
	placedStructure.structure = rotatedStructure
	placedStructure.originTile = targetTile
	map.add_child(placedStructure)
	placedStructure.position = targetTile.position
	
	for tile in affectedTiles:
		tile.structure = placedStructure.structure
		
	match card.structurePreview.structure.alignment:
		Structure.Alignment.Red:
			var unique_colors : Array[Structure.Alignment] = []
			var adjacents : Array[Tile] = placedStructure.structure.get_adjacent_tiles(map, targetTile)
			for t in adjacents:
				if (t.structure == null):
					continue
				if (!unique_colors.has(t.structure.alignment)):
					unique_colors.push_back(t.structure.alignment)
			score += unique_colors.size()
			
		Structure.Alignment.Yellow:
			var max : int = 0
			var colors : Dictionary = {}
			var adjacents : Array[Tile] = placedStructure.structure.get_adjacent_tiles(map, targetTile)
			for t in adjacents:
				if (t.structure == null):
					continue
				if (!colors.has(t.structure.alignment)):
					colors[t.structure.alignment] = 1
				else:
					colors[t.structure.alignment] += 1
				max = max(colors[t.structure.alignment], max)
				
			score += max
			
		Structure.Alignment.Blue:
			draw_card(deck, hand)
		Structure.Alignment.Green:
			score += 1
		Structure.Alignment.Orange:
			pass
		Structure.Alignment.Purple:
			gold += 1
			
	

func draw_card(deck: Deck, hand: Hand):
	var cardData = deck.pop_card()
	
	if (cardData == null):
		gameOver.emit(false)
	
	var card = cardSpawner.instantiate() as Card
	card.data = cardData
	card.global_position = deck.cardAnchor.global_position
	
	hand.add_card(card)

func discard_card(deck: Deck, card: Card):
	deck.tuck_card(card.data)
	card.queue_free()
