class_name GameApi
extends Node

signal cardGrabbed(card: Card)
signal cardReleased(card: Card)
signal cardPlayed(card: Card, tile: Tile, orientation_degrees: int)

@onready var cardSpawner = preload("res://cards/card.tscn")

func play_card(card: Card, target_tile: Tile):
	pass

func draw_card(deck: Deck, hand: Hand):
	var cardData = deck.cards.pop_front()
	
	var card = cardSpawner.instantiate() as Card
	card.data = cardData
	
	hand.add_card(card)

func discard_card(deck: Deck, hand: Hand, card: Card):
	pass
