class_name MetaGameState
extends Node

var subMissions: Array[SubMission]
var upkeepRules: Array[Effect]
var placementRules: Array[PlacementRule]
var playEffects: Array[Effect]
var cleanUpRules: Array[Effect]
var alignmentRules: Dictionary
var placementBonuses: Array[Keyword]
var settings: GameSettings = GameSettings.new()

func _ready():
	reset_rules()

func reset():
	reset_rules()
	Prompt.clear_prompts()
	Debug.push_message("Game reset!")

func create_deck() -> Array[CardData]:
	return CardPool.get_cards([
		"Scouts",
		"Foragers",
		"Farm",
		"Pasture",
		"City",
		"Temple",
		"Fishery",
		"Traders",
		"Mine",
		"Vault",
		"Marketplace",
		"Diplomats"
	] as Array[String])

func reset_rules():
	subMissions = [
		ConnectEachRock.new(AddFood.new(3)),
		ConnectEachWater.new(AddFood.new(3)),
		CoverAllCorners.new(AddFood.new(4)),
		TakeAllPlacementBonuses.new(AddFood.new(2)),
	]

	upkeepRules = [
		DrawCards.new(settings.baseHandSize),
		AddGold.new(settings.baseGoldIncome)
	]

	placementRules = [
		AdjacentStructureRule.new(),
		FreeSpaceRule.new(),
		TerrainRule.new(),
		PaymentRule.new()
	]

	playEffects = [
		PayCost.new(),
		PlaceStructure.new()
	]

	cleanUpRules = [
		DiscardHand.new(),
		Income.new()
	]

	alignmentRules = {
		Alignment.Id.Red: RedAlignment.new(),
		Alignment.Id.Yellow: YellowAlignment.new(),
		Alignment.Id.Blue: BlueAlignment.new(),
		Alignment.Id.Green: GreenAlignment.new(),
		Alignment.Id.Orange: OrangeAlignment.new(),
		Alignment.Id.Purple: PurpleAlignment.new(),
	}

	placementBonuses = [
		Draft.new(),
		Food.new(),
		Gold.new()
	]
