class_name EventBus
extends Node

# Game Events

signal onCardPlayed(args: PlayEffectArgs)
signal onStructurePlaced(args: PlacementEffectArgs)
signal onBeforeIncome(args: EffectArgs)
signal onAfterIncome(args: EffectArgs)
signal onCardsDrawn(args: EffectArgs, cards: Array[Card])
signal onCardsDiscarded(args: EffectArgs, cards: Array[CardData])
signal onCardsMilled(args: EffectArgs, cards: Array[CardData])
signal onPlacementBonusTriggered(args: PlacementEffectArgs, placementBonus: PlacementBonus)
signal onDiscoverTile(args: EffectArgs, tiles: Array[Tile])
signal onStructuresConverted(effect: ConvertStructures, args: EffectArgs, structures: Array[PlacedStructure])

signal gameOver(victory: bool)
signal foodChanged(oldValue: int, newValue: int, source: Array[Tile])
signal goldChanged(oldValue: int, newValue: int, source: Array[Tile])
