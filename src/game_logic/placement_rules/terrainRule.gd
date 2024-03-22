class_name TerrainRule
extends PlacementRule

func check(args: PlayEffectArgs) -> String:
    for tile in args.affectedTiles:
        match tile.type:
            TileInfo.TerrainType.Mountain:
                return "Cannot place on mountain"
            TileInfo.TerrainType.Water:
                return "Cannot place on water"
    return ""