class_name MetaGameState
extends Node

var cardSpawner = preload ("res://cards/card.tscn")
var structureSpawner = preload ("res://map/placed_structure.tscn")

var gold: int:
	get:
		return gold
	set(value):
		if (value == gold):
			return
		var oldValue = gold
		gold = value
		Events.goldChanged.emit(oldValue, gold)

var deck: Array[CardData] = [
	CardData.new("Quantum Nexus"),
	CardData.new("Hyperflux Prism"),
	CardData.new("Nebula Harmonics"),
	CardData.new("Singularity Synchrony"),
	CardData.new("Chrono Fractal"),
	CardData.new("Warp Resonance"),
	CardData.new("Quantum Lattice"),
	CardData.new("Aetheric Enigma"),
	CardData.new("Void Mandala"),
	CardData.new("Celestial Geodesic"),
	CardData.new("Nebular Conundrum"),
]

var placementRules: Array[PlacementRule] = [
	AdjacentStructureRule.new(),
	FreeSpaceRule.new(),
	TerrainRule.new()
]

func reset():
	gold = 0
