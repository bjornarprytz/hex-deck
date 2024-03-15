class_name EventBus
extends Node

# Interaction Events

signal cardGrabbed(card: Card)
signal cardReleased(card: Card)
signal tileClicked(tile: Tile)
signal tileHovered(tile: Tile)

# Game Events

signal cardPlayed(card: Card, tile: Tile, orientation_degrees: int)
signal gameOver(victory: bool)
signal foodRequirementChanged(oldValue: int, newValue: int)
signal foodChanged(oldValue: int, newValue: int, source: Array[Tile])
signal goldChanged(oldValue: int, newValue: int, source: Array[Tile])
