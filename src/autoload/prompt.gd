class_name PromptManager
extends Node2D

@onready var tradeSpawner = preload ("res://ui/prompt/trade_prompt.tscn")
@onready var buySpawner = preload ("res://ui/prompt/buy_prompt.tscn")
@onready var draftSpawner = preload ("res://ui/prompt/draft_prompt.tscn")

@onready var promptContainer: CanvasLayer = $Root
@onready var background: ColorRect = $Root/BackgroundBlur
@onready var baseBackgroundColor: Color = background.color

func buy() -> Array[Effect]:
	background_on()
	var prompt = buySpawner.instantiate() as BuyPrompt
	promptContainer.add_child(prompt)
	var effects = await prompt.confirm

	prompt.queue_free()
	background_off()
	return effects

func trade(hand: Hand, mandatory: bool=false) -> Array:
	background_on()
	var oldParent = hand.get_parent()
	hand.reparent(promptContainer)
	var prompt = tradeSpawner.instantiate() as TradePrompt
	prompt.hand = hand
	prompt.mandatory = mandatory
	promptContainer.add_child(prompt)

	var result = await prompt.confirm

	prompt.queue_free()
	background_off()
	hand.reparent(oldParent)

	return result

func draft(cards: Array[CardData]):
	background_on()
	var prompt = draftSpawner.instantiate() as DraftPrompt
	promptContainer.add_child(prompt)
	
	for cardData in cards:
		prompt.add_card(cardData)
	
	var draftedCard = await prompt.choice
	prompt.queue_free()
	background_off()

	return draftedCard

func background_on():
	background.color.a = 0
	background.visible = true
	create_tween().tween_property(background, 'color', baseBackgroundColor, .2)
	
func background_off():
	background.visible = false
