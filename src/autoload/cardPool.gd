class_name CardPoolCollection
extends Node2D

func _ready():
	# Load all the cards
	for card in _generate_cards():
		if cardPool.has(card.name):
			print("Card with name " + card.name + " already exists in the card pool")
		else:
			cardPool[card.name] = card

var cardPool: Dictionary

func get_random_cards(count: int) -> Array[CardData]:
	var cards: Array[CardData] = []
	for i in range(count):
		cards.push_back(get_random_card())
	return cards

func get_random_card() -> CardData:
	var cardNames: Array[String] = []
	for cardName in cardPool.keys():
		cardNames.push_back(cardName)
	return get_card(cardNames.pick_random())

func get_cards(names: Array[String]) -> Array[CardData]:
	var cards: Array[CardData] = []
	for cardName in names:
		cards.push_back(get_card(cardName))
	return cards

func get_card(cardName: String) -> CardData:
	if cardPool.has(cardName):
		return cardPool[cardName]
	else:
		push_error("Card with name " + cardName + " does not exist in the card pool")
		return null

func _generate_cards() -> Array[CardData]:
	return [
		CardData.Create("Scouts", Utils.structure_size(1), Alignment.Id.Orange) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([Scout.new()]) \
				),
		CardData.Create("Foragers", Utils.structure_size(1), Alignment.Id.Orange) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([Forage.new()]) \
				),

		CardData.Create("Farm", Utils.structure_size(1), Alignment.Id.Green) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([EachConnectedTile.new(FoodForUniformityInTilePile.new())]) \
				),
		CardData.Create("Pasture", Utils.structure_size(1), Alignment.Id.Green) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([AddFood.new()]) \
				),

		CardData.Create("City", Utils.structure_size(2), Alignment.Id.Yellow) \
			.with_gold_cost(2) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([Draft.new()]) \
				.with_adjacent_placement_effects([Envelop.new(5, FoodForUniformityInTilePile.new())]) \
				),
		CardData.Create("Temple", Utils.structure_size(1), Alignment.Id.Yellow) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([EachAdjacentTile.new(ConvertStructures.new(Alignment.Id.Orange, Alignment.Id.Green))]) \
				),

		CardData.Create("Fishery", Utils.structure_size(1), Alignment.Id.Blue) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_rules([AdjacentAffinityRule.new(TileInfo.TerrainType.Water)]) \
				.with_placement_effects([Fishing.new(3, FoodForVarietyInCardPile.new())]) \
				),

		CardData.Create("Traders", Utils.structure_size(1), Alignment.Id.Blue) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_rules([AdjacentAffinityRule.new(TileInfo.TerrainType.Water)]) \
				.with_placement_effects([DrawCards.new(), Trade.new()]) \
				),

		CardData.Create("Mine", Utils.structure_size(1), Alignment.Id.Purple) \
			.with_gold_cost(1) \
			.with_food_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_rules([AdjacentAffinityRule.new(TileInfo.TerrainType.Mountain)]) \
				.with_placement_effects([AddGold.new(3)]) \
				),
		CardData.Create("Vault", Utils.structure_size(1), Alignment.Id.Purple) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([RetainCards.new()]) \
				),
		
		CardData.Create("Marketplace", Utils.structure_size(1), Alignment.Id.Red) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([EachAdjacentTile.new(FoodForVarietyInTilePile.new())]) \
				),
		CardData.Create("Diplomats", Utils.structure_size(1), Alignment.Id.Red) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([DrawCards.new(), Wild.new()]) \
				),
	]
