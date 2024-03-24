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
				## TODO: Implement Scouting (food for each empty adjacent tile)
				.with_placement_effects([]) \
				),
		CardData.Create("Foragers", Utils.structure_size(1), Alignment.Id.Orange) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				## TODO: Add food per adjacent placement bonus
				.with_placement_effects([]) \
				),

		CardData.Create("Farm", Utils.structure_size(1), Alignment.Id.Green) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				## TODO: Add concept of connected structures
				.with_placement_effects([]) \
				),
		CardData.Create("Pasture", Utils.structure_size(1), Alignment.Id.Green) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([AddFood.new()]) \
				),

		CardData.Create("City", Utils.structure_size(2), Alignment.Id.Yellow) \
			.with_gold_cost(2) \
			.with_special_rules(RulesHooks.new() \
				## TODO: Add an effect which adds food per uniform tile, when surrounded
				.with_adjacent_placement_effects([]) \
				),
		CardData.Create("Temple", Utils.structure_size(1), Alignment.Id.Yellow) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				## TODO: Add an effect which converts from orange to green
				.with_placement_effects([]) \
				),

		CardData.Create("Fishery", Utils.structure_size(1), Alignment.Id.Blue) \
			.with_gold_cost(1) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_rules([AdjacentAffinityRule.new(TileInfo.TerrainType.Water)]) \
				.with_placement_effects([Fishing.new(3, FoodPerVariety.new())]) \
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
				.with_placement_effects([AddFoodPerDifferentTile.new()]) \
				),
		CardData.Create("Diplomats", Utils.structure_size(1), Alignment.Id.Red) \
			.with_special_rules(RulesHooks.new() \
				.with_placement_effects([DrawCards.new(), ChangeColor.new()]) \
				),
	]
