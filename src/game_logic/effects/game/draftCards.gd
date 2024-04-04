class_name DraftCards
extends Effect

var draftPool: Array[CardData]

func _init(pool: Array[CardData]=[]) -> void:
	draftPool = pool

func resolve(args: EffectArgs):
	var cardsToDraft: Array[CardData] = []
	cardsToDraft.append_array(draftPool)
	
	if (cardsToDraft.size() <= 1):
		cardsToDraft.append_array(CardPool.get_random_cards(3))

	var draftedCard = await Prompt.draft(cardsToDraft)
	
	args.gameState.drawPile.tuck_card(draftedCard)
