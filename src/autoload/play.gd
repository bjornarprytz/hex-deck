class_name GameApi
extends Node

signal cardGrabbed(card: Card)
signal cardReleased(card: Card)
signal cardPlayed(card: Card, tile: Tile, orientation_degrees: int)
signal tileClicked(tile: Tile)
signal tileHovered(tile: Tile)

@onready var cardSpawner = preload("res://cards/card.tscn")

func play_card(card: Card, targetTile: Tile, rotationSteps: int):
	var rotatedStructure = card.data.structure.get_rotated(rotationSteps)
	
	for cell in rotatedStructure.cells:
		var targetCoord = targetTile.coordinates.add_vec(cell)
		print("Affecting (%s)" % targetCoord.get_key())

func draw_card(deck: Deck, hand: Hand):
	var cardData = deck.cards.pop_front()
	
	var card = cardSpawner.instantiate() as Card
	card.data = cardData
	card.global_position = deck.cardAnchor.global_position
	
	hand.add_card(card)

func discard_card(deck: Deck, hand: Hand, card: Card):
	pass
