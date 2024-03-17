class_name PickCards
extends Node2D

signal choices(cards: Array[Card])

var minPicks: int
var maxPicks: int
var requireConfirm: bool:
	set(value):
		requireConfirm = value
		$Button.visible = value
var options: Array[Card]:
	set(value):
		options = value
		for card in value:
			card.clicked.connect(update_selection.bind(card))

var selection: Array[Card] = []

func _on_button_pressed() -> void:
	if (selection.size() <= maxPicks and selection.size() >= minPicks):
		choices.emit(selection)

func update_selection(card: Card):
	if selection.has(card):
		selection.erase(card)
	else:
		selection.push_back(card)
	
	if !requireConfirm and selection.size() >= minPicks and selection.size() <= maxPicks:
		choices.emit(selection)

static func from(pool: Array[Card], mmin: int=1, mmax: int=mmin) -> Array[Card]:
	assert(mmax >= mmin)
	
	var pickCards = preload ("res://ui/pick_cards.tscn").instantiate() as PickCards
	Meta.add_child(pickCards)
	pickCards.minPicks = mmin
	pickCards.maxPicks = mmax
	pickCards.options = pool
	pickCards.requireConfirm = true
	
	var result = await pickCards.choices
	
	pickCards.queue_free()
	
	return result

static func one(pool: Array[Card], autoConfirm: bool=true) -> Card:
	var pickCards = preload ("res://ui/pick_cards.tscn").instantiate() as PickCards
	Meta.add_child(pickCards)
	pickCards.minPicks = 1
	pickCards.maxPicks = 1
	pickCards.options = pool
	pickCards.requireConfirm = !autoConfirm
	
	var result = await pickCards.choices
	assert(result.size() == 1)
	
	pickCards.queue_free()
	
	return result[0]
