class_name SubMission
extends Resource

signal progress(current: int, goal: int)
signal completed()

var reward: Effect
var currentProgress: int = 0
var goal: int = 0

func _init(rewardEffect: Effect) -> void:
    reward = rewardEffect

func description() -> String:
    push_error("SubMission.description() must be overridden in a subclass")
    return ""

func start(_gameState: GameState):
    push_error("SubMission.start() must be overridden in a subclass")