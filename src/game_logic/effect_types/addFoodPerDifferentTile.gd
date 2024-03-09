class_name AddFoodPerDifferentTile
extends Effect

func resolve(args: PlayArgs):
    var unique_colors: Array[Color] = []
    for t in args.adjacentTiles:
        if (t.structure == null):
            continue
        var color = t.structure.alignment.get_color()
        if !unique_colors.has(color):
            unique_colors.push_back(color)
        
    args.gameState.food += unique_colors.size()

func rules_text() -> String:
    return "Add food equal to the number of unique colors among adjacent tiles"