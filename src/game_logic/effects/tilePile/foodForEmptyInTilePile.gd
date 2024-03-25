class_name FoodForEmptyInTilePile
extends TilePileEffect

func resolve(args: TilePileEffectArgs):
    var total = 0
    for tile in args.tiles:
        if !tile.has_structure():
            total += 1

    args.gameState.add_food(total)

func keyword():
    return "Food: Empty Tiles"