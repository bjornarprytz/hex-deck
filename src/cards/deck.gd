class_name Deck
extends Node2D

@onready var cards : Array[CardData] = [
	CardData.new("Quantum Nexus"),
	CardData.new("Hyperflux Prism"),
	CardData.new("Nebula Harmonics"),
	CardData.new("Singularity Synchrony"),
	CardData.new("Chrono Fractal"),
	CardData.new("Warp Resonance"),
	CardData.new("Quantum Lattice"),
	CardData.new("Aetheric Enigma"),
	CardData.new("Void Mandala"),
	CardData.new("Celestial Geodesic"),
	CardData.new("Nebular Conundrum"),
]

@onready var cardAnchor : Node2D = $Color/CardAnchor
@onready var cardCount : RichTextLabel = $CardCount


func tuck_card(cardData: CardData):
	cards.push_back(cardData)
	_update_card_count()

func push_card(cardData: CardData):
	cards.push_front(cardData)
	_update_card_count()

func pop_card() -> CardData:
	var card = cards.pop_front()
	_update_card_count()
	return card

func _update_card_count():
	cardCount.text = str(cards.size())
