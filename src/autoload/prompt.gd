class_name PromptManager
extends Node2D

@onready var tradeSpawner = preload ("res://ui/prompt/trade_prompt.tscn")
@onready var buySpawner = preload ("res://ui/prompt/buy_prompt.tscn")
@onready var draftSpawner = preload ("res://ui/prompt/draft_prompt.tscn")
@onready var fromHandSpawner = preload ("res://ui/prompt/from_hand_prompt.tscn")

@onready var promptContainer: Node2D = $Root/Prompts
@onready var background: ColorRect = $Root/BackgroundBlur
@onready var baseBackgroundColor: Color = background.color

func clear_prompts():
	for child in promptContainer.get_children():
		child.queue_free()

func buy() -> Array[Effect]:
	_background_on()
	var prompt = buySpawner.instantiate() as BuyPrompt
	promptContainer.add_child(prompt)
	var effects = await prompt.confirm

	prompt.queue_free()
	_background_off()
	return effects

func trade(hand: Hand, mandatory: bool=false) -> Array:
	_background_on()
	var oldParent = hand.get_parent()
	hand.reparent(promptContainer)
	var prompt = tradeSpawner.instantiate() as TradePrompt
	prompt.hand = hand
	prompt.mandatory = mandatory
	promptContainer.add_child(prompt)

	var result = await prompt.confirm

	prompt.queue_free()
	_background_off()
	hand.reparent(oldParent)

	return result

func draft(cards: Array[CardData]):
	_background_on()
	var prompt = draftSpawner.instantiate() as DraftPrompt
	promptContainer.add_child(prompt)
	
	for cardData in cards:
		prompt.add_card(cardData)
	
	var draftedCard = await prompt.choice
	prompt.queue_free()
	_background_off()

	return draftedCard

func nFromHand(hand: Hand, nCards: int, explanation: String, requireConfirm: bool=true) -> Array[Card]:
	var prompt = fromHandSpawner.instantiate() as FromHandPrompt
	promptContainer.add_child(prompt)

	prompt.hand = hand
	prompt.nCardsToSelect = nCards
	prompt.explanation = explanation
	prompt.requireConfirm = requireConfirm

	var cards = await prompt.confirm

	prompt.queue_free()
	return cards

func oneFromHand(hand: Hand, explanation: String, requireConfirm: bool=false) -> Card:
	var cards = await nFromHand(hand, 1, explanation, requireConfirm)

	assert(cards.size() == 1)

	return cards[0]

func _background_on():
	background.color.a = 0
	background.visible = true
	create_tween().tween_property(background, 'color', baseBackgroundColor, .2)
	
func _background_off():
	background.visible = false
