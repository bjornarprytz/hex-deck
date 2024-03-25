class_name CardPileEffectArgs
extends EffectArgs

var cards: Array[Card]

func _init(inputGameState: GameState, inputCards: Array[Card]) -> void:
	super._init(inputGameState)
	cards = inputCards
