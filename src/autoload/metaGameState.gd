class_name MetaGameState
extends Node

var cardSpawner = preload ("res://cards/card.tscn")
var structureSpawner = preload ("res://map/placed_structure.tscn")

var deck: Array[CardData] = [
	CardData.Create(1, Alignment.Id.Green).with_gold_cost(1),
	CardData.Create(1, Alignment.Id.Green).with_gold_cost(1),
	CardData.Create(1, Alignment.Id.Green).with_gold_cost(1),
	CardData.Create(1, Alignment.Id.Purple).with_gold_cost(1),
	CardData.Create(1, Alignment.Id.Yellow).with_gold_cost(1),
	CardData.Create(1, Alignment.Id.Orange).with_gold_cost(1),
	CardData.Create(1, Alignment.Id.Red).with_gold_cost(1),
	CardData.Create(1, Alignment.Id.Green).with_gold_cost(1),
	CardData.Create(2, Alignment.Id.Red).with_gold_cost(1),
	CardData.Create(3, Alignment.Id.Green).with_gold_cost(1),
]

var upkeepRules: Array[Effect] = [
	DrawCard.new(5),
	AddGold.new(3)
]

var placementRules: Array[PlacementRule] = [
	AdjacentStructureRule.new(),
	FreeSpaceRule.new(),
	TerrainRule.new(),
	PaymentRule.new()
]

var playEffects: Array[Effect] = [
	PayCost.new(),
	PlaceStructure.new()
]

var cleanUpRules: Array[Effect] = [
	DiscardHand.new(),
	Income.new()
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
	Debug.push_message("Game reset!")
	pass
