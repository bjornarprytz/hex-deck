class_name AdjacentPlacementEffectArgs
extends EffectArgs

var adjacentStructure: PlacedStructure
var newlyPlacedStructure: PlacedStructure

func _init(inputGameState: GameState, inputAdjacentStructure: PlacedStructure, inputNewlyPlacedStructure: PlacedStructure):
    super._init(inputGameState)
    adjacentStructure = inputAdjacentStructure
    newlyPlacedStructure = inputNewlyPlacedStructure
