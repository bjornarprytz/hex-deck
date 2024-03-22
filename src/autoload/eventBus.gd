class_name EventBus
extends Node

# Game Events

signal onCardPlayed(args: PlayEffectArgs)
signal onStructurePlaced(args: StructureEffectArgs)
signal onBeforeIncome(args: EffectArgs)
signal onAfterIncome(args: EffectArgs)
signal onCardsDrawn(args: EffectArgs, cards: Array[Card])
signal onCardsDiscarded(args: EffectArgs, cards: Array[CardData])
signal onPlacementBonusTriggered(args: StructureEffectArgs, placementBonus: PlacementBonus)
signal onDiscoverTile(args: EffectArgs, tiles: Array[Tile])

signal gameOver(victory: bool)
signal foodRequirementChanged(oldValue: int, newValue: int)
signal foodChanged(oldValue: int, newValue: int, source: Array[Tile])
signal goldChanged(oldValue: int, newValue: int, source: Array[Tile])
