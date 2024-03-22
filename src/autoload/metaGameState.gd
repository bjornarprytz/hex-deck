class_name MetaGameState
extends Node

var cardSpawner = preload ("res://cards/card.tscn")
var structureSpawner = preload ("res://map/placed_structure.tscn")

var basicSet: Array[CardData] = [
	CardData.Create("Basic Red", MetaGameState.size(1), Alignment.Id.Red).with_gold_cost(1),
	CardData.Create("Basic Yellow", MetaGameState.size(1), Alignment.Id.Yellow).with_gold_cost(1),
	CardData.Create("Basic Blue", MetaGameState.size(1), Alignment.Id.Blue).with_gold_cost(1),
	CardData.Create("Basic Green", MetaGameState.size(1), Alignment.Id.Green).with_gold_cost(1),
	CardData.Create("Basic Orange", MetaGameState.size(1), Alignment.Id.Orange).with_gold_cost(1),
	CardData.Create("Basic Purple", MetaGameState.size(1), Alignment.Id.Purple).with_gold_cost(1),
]

var cardPool: Array[CardData] = [
	CardData.Create("Gold Mine", MetaGameState.size(1), Alignment.Id.Purple) \
		.with_gold_cost(3) \
		.with_special_rules(RulesHooks.new() \
			.with_placement_rules([AdjacentAffinityRule.new(TileInfo.TerrainType.Mountain)]) \
			.with_income_effects([PayFood.new(1), AddGold.new(1)]) \
			),
	CardData.Create("Fishery", MetaGameState.size(1), Alignment.Id.Blue) \
		.with_gold_cost(1) \
		.with_special_rules(RulesHooks.new() \
			.with_placement_rules([AdjacentAffinityRule.new(TileInfo.TerrainType.Water)]) \
			.with_placement_effects([DrawCards.new(), Trade.new()]) \
			),
	CardData.Create("Village I", MetaGameState.size(1), Alignment.Id.Yellow) \
		.with_gold_cost(1) \
		.with_special_rules(RulesHooks.new() \
			.with_placement_effects([AddFoodPerSimilarTile.new()]) \
			),
	CardData.Create("Village II", MetaGameState.size(2), Alignment.Id.Yellow) \
		.with_gold_cost(2) \
		.with_special_rules(RulesHooks.new() \
			.with_placement_effects([AddFoodPerSimilarTile.new()]) \
			),
	CardData.Create("Village III", MetaGameState.size(3), Alignment.Id.Yellow) \
		.with_gold_cost(3) \
		.with_special_rules(RulesHooks.new() \
			.with_placement_effects([AddFoodPerSimilarTile.new()]) \
			),
	CardData.Create("Farm", MetaGameState.size(1), Alignment.Id.Green) \
		.with_gold_cost(2) \
		.with_special_rules(RulesHooks.new() \
			.with_income_effects([AddFood.new()]) \
			),
	CardData.Create("Marketplace", MetaGameState.size(1), Alignment.Id.Red) \
		.with_gold_cost(1) \
		.with_special_rules(RulesHooks.new() \
			.with_placement_effects([AddFoodPerDifferentTile.new()]) \
			),
]

var upkeepRules: Array[Effect] = [
	DrawCards.new(5),
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

var settings: GameSettings = GameSettings.new()

var placementBonuses: Array[Effect] = [
	Draft.new(),
	AddFood.new(),
	AddFoodPerDifferentTile.new()
]

func random_tile_type() -> TileInfo.TerrainType:
	var total = 0
	var tilePool = settings.terrainTypePool

	var inTheRunning = tilePool.keys()

	for type in tilePool.keys():
		var subTotal = tilePool[type]
		if subTotal == 0:
			inTheRunning.erase(type)
		
		total += subTotal
	
	var index = randi_range(0, total)

	for type in inTheRunning:
		index -= tilePool[type]
		if (index <= 0):
			tilePool[type] -= 1
			return type
	
	print("Ran out of index, returning random tile")
	return TileInfo.TerrainType.values().pick_random()

func random_tile_data() -> TileInfo:
	var type = random_tile_type()
	var placementBonus: PlacementBonus = null
	if (type == TileInfo.TerrainType.Basic and randf() < .2):
		placementBonus = PlacementBonus.new([Meta.placementBonuses.pick_random()])
	
	return TileInfo.new(type, placementBonus)

func reset():
	settings = GameSettings.new()
	Prompt.clear_prompts()
	Debug.push_message("Game reset!")

func create_deck() -> Array[CardData]:
	var deck: Array[CardData] = []

	deck.append_array(basicSet)
	deck.push_back(cardPool.pick_random())
	deck.push_back(cardPool.pick_random())
	deck.push_back(cardPool.pick_random())
	deck.push_back(cardPool.pick_random())

	return deck

static func size(s: int) -> Array[Vector2i]:
	return standardStructures[s - 1]

static var standardStructures: Array = [
	Utils.get_cells(),
	Utils.get_cells([[1, -1]]),
	Utils.get_cells([[1, -1], [1, 0]]),
	Utils.get_cells([[1, -1], [1, 0], [0, -1]]),
	Utils.get_cells([[1, -1], [1, 0], [0, -1], [0, 1]]),
]
