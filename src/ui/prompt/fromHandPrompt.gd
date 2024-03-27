class_name FromHandPrompt
extends Node2D

signal confirm(cards: Array[Card])

@onready var confirmButton: Button = $ConfirmButton
@onready var explanationLabel: RichTextLabel = $Explanation

var selectedCards: Array[Card] = []

var maxCardsToSelect: int
var minCardsToSelect: int

var requireConfirm: bool:
	set(value):
		requireConfirm = value
		confirmButton.visible = requireConfirm
var explanation: String:
	set(value):
		explanation = value
		explanationLabel.text = value
		
		explanationLabel.visible = value.length() > 0

var hand: Hand:
	set(value):
		hand = value
		hand.cardClicked.connect(_toggle_select)

func _toggle_select(card: Card):
	if selectedCards.has(card):
		card.selected = false
		selectedCards.erase(card)
	else:
		selectedCards.push_back(card)
		card.selected = true
	
	if !requireConfirm:
		_try_confirm()
	elif _selection_is_within_bounds():
		confirmButton.disabled = false
	else:
		confirmButton.disabled = true

func _try_confirm():
	if !_selection_is_within_bounds():
		return
	
	for card in selectedCards:
		card.selected = false
	confirm.emit(selectedCards)

func _on_confirm_button_pressed() -> void:
	_try_confirm()

func _selection_is_within_bounds() -> bool:
	return selectedCards.size() >= minCardsToSelect and selectedCards.size() <= maxCardsToSelect
