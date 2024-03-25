class_name EachAdjacentTile
extends Effect

var tilePileEffect: TilePileEffect

func _init(inputTilePileEffect: TilePileEffect):
    tilePileEffect = inputTilePileEffect

func resolve(args: PlacementEffectArgs):
    await tilePileEffect.resolve(TilePileEffectArgs.new(args.gameState, args.adjacentTiles))

func rules_text() -> String:
    return "Resolve an effect per adjacent tile."

func keyword() -> String:
    return "Adjacent: %s" % tilePileEffect.keyword()