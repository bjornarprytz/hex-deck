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
	CardData.Random("Quantum Nexus"),
	CardData.Random("Hyperflux Prism"),
	CardData.Random("Nebula Harmonics"),
	CardData.Random("Singularity Synchrony"),
	CardData.Random("Chrono Fractal"),
	CardData.Random("Warp Resonance"),
	CardData.Random("Quantum Lattice"),
	CardData.Random("Aetheric Enigma"),
	CardData.Random("Void Mandala"),
	CardData.Random("Celestial Geodesic"),
	CardData.Random("Nebular Conundrum"),
]

var placementRules: Array[PlacementRule] = [
	AdjacentStructureRule.new(),
	FreeSpaceRule.new(),
	TerrainRule.new()
]

var alignmentRules: Dictionary = {
	Alignment.Id.Red: RedAlignment.new(),
	Alignment.Id.Yellow: YellowAlignment.new(),
	Alignment.Id.Blue: BlueAlignment.new(),
	Alignment.Id.Green: GreenAlignment.new(),
	Alignment.Id.Orange: OrangeAlignment.new(),
	Alignment.Id.Purple: PurpleAlignment.new(),
}

func reset():
	gold = 0
