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
			.with_keywords([Scout.new()]),

		CardData.Create("Foragers", Utils.structure_size(1), Alignment.Id.Orange) \
			.with_gold_cost(1) \
			.with_keywords([Forage.new()]),

		CardData.Create("Farm", Utils.structure_size(1), Alignment.Id.Green) \
			.with_gold_cost(1) \
			.with_keywords([ConnectedForUniformity.new()]),

		CardData.Create("Pasture", Utils.structure_size(1), Alignment.Id.Green) \
			.with_gold_cost(1) \
			.with_keywords([Food.new()]),

		CardData.Create("City", Utils.structure_size(2), Alignment.Id.Yellow) \
			.with_gold_cost(2) \
			.with_keywords([Draft.new(), EnvelopForUniformity.new(5)]),

		CardData.Create("Temple", Utils.structure_size(1), Alignment.Id.Yellow) \
			.with_gold_cost(1) \
			.with_keywords([ConvertAdjacent.new(Alignment.Id.Orange, Alignment.Id.Green)]),

		CardData.Create("Fishery", Utils.structure_size(1), Alignment.Id.Blue) \
			.with_gold_cost(1) \
			.with_keywords([WaterAffinity.new(), FishingForVariety.new(3)]),

		CardData.Create("Traders", Utils.structure_size(1), Alignment.Id.Blue) \
			.with_gold_cost(1) \
			.with_keywords([WaterAffinity.new(), Draw.new(), Trade.new()]),

		CardData.Create("Mine", Utils.structure_size(1), Alignment.Id.Purple) \
			.with_gold_cost(1) \
			.with_food_cost(1) \
			.with_keywords([MountainAffinity.new(), Gold.new(3)]),
			
		CardData.Create("Vault", Utils.structure_size(1), Alignment.Id.Purple) \
			.with_keywords([Retain.new()]),
		
		CardData.Create("Marketplace", Utils.structure_size(1), Alignment.Id.Red) \
			.with_gold_cost(1) \
			.with_keywords([AdjacentTilesForVariety.new()]),
			
		CardData.Create("Diplomats", Utils.structure_size(1), Alignment.Id.Red) \
			.with_keywords([Draw.new(), Wild.new()])
	]
