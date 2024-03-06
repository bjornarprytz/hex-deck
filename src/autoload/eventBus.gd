class_name EventBus
extends Node

signal cardGrabbed(card: Card)
signal cardReleased(card: Card)
signal cardPlayed(card: Card, tile: Tile, orientation_degrees: int)
signal tileClicked(tile: Tile)
signal tileHovered(tile: Tile)
signal gameOver(victory: bool)
signal scoreRequirementChanged(oldValue: int, newValue: int)
signal scoreChanged(oldValue: int, newValue: int)
signal goldChanged(oldValue: int, newValue: int)
