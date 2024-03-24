class_name Buy
extends Effect

func resolve(args: EffectArgs):
    var effects = await Prompt.buy()

    for effect in effects:
        await effect.resolve(args)

func rules_text() -> String:
    return "Buy 1 food for 1 gold, or vice versa"

func keyword() -> String:
    return "Buy"