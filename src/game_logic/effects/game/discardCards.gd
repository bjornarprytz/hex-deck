class_name DiscardCards
extends Effect

var amount: int

func _init(inputAmount: int=1):
    amount = inputAmount

func resolve(args: EffectArgs):
    if (amount == 0):
        return

    var hand = args.gameState.hand
    var cards: Array[CardData] = []

    var cardsToDiscard = await PickCards.from(hand.get_cards(), amount)

    for card in cardsToDiscard:
        cards.push_back(args.gameState.discard_card(card))

    Events.onCardsDiscarded.emit(args, cards)

func rules_text() -> String:
    return "Discard %d cards" % amount
