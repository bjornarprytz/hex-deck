class_name DiscardPile
extends Node2D

@onready var cardCount: RichTextLabel = $CardCount
@onready var _pileInfo: PileInfo = $PileInfo

var cards: Array[CardData] = []

func add_card(cardData: CardData):
	cards.push_front(cardData)
	_update_card_count()

func remove_card(cardData: CardData) -> CardData:
	var index = cards.find(cardData)
	if index == - 1:
		return null
	var card = cards[index]
	cards.remove_at(index)
	_update_card_count()
	return card

func remove_all() -> Array[CardData]:
	var result = cards.duplicate()
	cards.clear()
	_update_card_count()
	return result

func _update_card_count():
	cardCount.text = str(cards.size())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		_pileInfo.hide()

func _on_color_pressed() -> void:
	if _pileInfo.visible:
		_pileInfo.hide()
	else:
		_pileInfo.show()
		_pileInfo.cards = cards
