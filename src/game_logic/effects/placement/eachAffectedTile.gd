class_name EachAffectedTile
extends Effect

var tilePileEffect: TilePileEffect

func _init(inputTilePileEffect: TilePileEffect):
    tilePileEffect = inputTilePileEffect

func resolve(args: PlacementEffectArgs):
    await tilePileEffect.resolve(TilePileEffectArgs.new(args.gameState, args.affectedTiles))

func rules_text() -> String:
    return "Resolve an effect per affected tile."

func keyword() -> String:
    return "Affected Tiles: %s" % tilePileEffect.keyword()