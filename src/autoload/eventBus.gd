class_name EventBus
extends Node

signal cardGrabbed(card: Card)
signal cardReleased(card: Card)
signal cardPlayed(card: Card, tile: Tile, orientation_degrees: int)
signal tileClicked(tile: Tile)
signal tileHovered(tile: Tile)
signal gameOver(victory: bool)
signal foodRequirementChanged(oldValue: int, newValue: int)
signal foodChanged(oldValue: int, newValue: int)
signal goldChanged(oldValue: int, newValue: int)
