class_name GameSettingsController
extends Node2D

@onready var randomSeed: LineEdit = $Container/Seed/LineEdit
@onready var terrainPoolWater: LineEdit = $Container/TerrainTypePool/Water
@onready var terrainPoolMountain: LineEdit = $Container/TerrainTypePool/Mountain
@onready var terrainPoolBasic: LineEdit = $Container/TerrainTypePool/Basic
@onready var mapRadius: LineEdit = $Container/MapRadius/LineEdit
@onready var foodRequirement: LineEdit = $Container/FoodRequirement/LineEdit
@onready var totalTurns: LineEdit = $Container/TotalTurns/LineEdit
@onready var baseGoldIncome: LineEdit = $Container/BaseGoldIncome/LineEdit
@onready var baseHandSize: LineEdit = $Container/HandSize/LineEdit

@onready var tileCount: RichTextLabel = $TileCount

func _ready():
	mapRadius.text_changed.connect(_radius_changed)
	_update_ui()

func _radius_changed(newText: String) -> void:
	var value = newText.to_int()
	
	if value <= 0:
		tileCount.text = "0 Tiles"
		return

	var total = 1

	for i in range(value):
		total += (i * 6)

	tileCount.text = "%d Tiles" % [total]

func _on_play_pressed() -> void:
	_save_settings()
	Meta.reset()
	get_tree().change_scene_to_file("res://main.tscn")

func _save_settings():
	var settings = GameSettings.new()

	settings.randomSeed = randomSeed.text.to_int()
	settings.set_terrain_pool(terrainPoolBasic.text.to_int(), terrainPoolWater.text.to_int(), terrainPoolMountain.text.to_int())
	settings.mapRadius = mapRadius.text.to_int()
	settings.foodRequirement = foodRequirement.text.to_int()
	settings.totalTurns = totalTurns.text.to_int()
	settings.baseGoldIncome = baseGoldIncome.text.to_int()
	settings.baseHandSize = baseHandSize.text.to_int()
	
	Meta.settings = settings

func _reset_settings():
	Meta.settings = GameSettings.new()
	_update_ui()

func _update_ui():
	randomSeed.text = str(Meta.settings.randomSeed)
	terrainPoolBasic.text = str(Meta.settings._terrainTypePool[TileInfo.TerrainType.Basic])
	terrainPoolMountain.text = str(Meta.settings._terrainTypePool[TileInfo.TerrainType.Mountain])
	terrainPoolWater.text = str(Meta.settings._terrainTypePool[TileInfo.TerrainType.Water])
	mapRadius.text = str(Meta.settings.mapRadius)
	foodRequirement.text = str(Meta.settings.foodRequirement)
	totalTurns.text = str(Meta.settings.totalTurns)
	baseGoldIncome.text = str(Meta.settings.baseGoldIncome)
	baseHandSize.text = str(Meta.settings.baseHandSize)

	_radius_changed(mapRadius.text)

func _on_reset_pressed() -> void:
	_reset_settings()
