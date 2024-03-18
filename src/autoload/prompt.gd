class_name PromptManager
extends Node2D

@onready var tradeSpawner = preload ("res://ui/prompt/trade_prompt.tscn")
@onready var buySpawner = preload ("res://ui/prompt/buy_prompt.tscn")
@onready var draftSpawner = preload ("res://ui/prompt/draft_prompt.tscn")

func buy() -> Array[Effect]:
	var prompt = buySpawner.instantiate() as BuyPrompt
	add_child(prompt)
	var effects = await prompt.confirm

	prompt.queue_free()

	return effects

func trade(hand: Hand, mandatory: bool=false) -> Array:
	var prompt = tradeSpawner.instantiate() as TradePrompt
	prompt.hand = hand
	prompt.mandatory = mandatory
	add_child(prompt)

	var result = await prompt.confirm

	prompt.queue_free()

	return result

func draft(cards: Array[CardData]):
	var prompt = draftSpawner.instantiate() as DraftPrompt
	add_child(prompt)
	
	for cardData in cards:
		prompt.add_card(cardData)
	
	var draftedCard = await prompt.choice
	prompt.queue_free()
	return draftedCard
