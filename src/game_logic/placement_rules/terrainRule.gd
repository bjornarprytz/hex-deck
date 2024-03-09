class_name TerrainRule
extends PlacementRule

func check(args: PlayArgs) -> String:
    for tile in args.affectedTiles:
        match tile.type:
            Tile.TerrainType.Mountain:
                return "Cannot place on mountain"
            Tile.TerrainType.Water:
                return "Cannot place on water"
    return ""