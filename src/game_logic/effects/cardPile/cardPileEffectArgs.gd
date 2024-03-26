class_name CardPileEffectArgs
extends EffectArgs

var cards: Array[CardData]

func _init(inputGameState: GameState, inputCards: Array[CardData]) -> void:
	super._init(inputGameState)
	cards = inputCards
