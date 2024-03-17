class_name Buy
extends Effect

func resolve(args: EffectArgs):
    var effects = await BuyPrompt.ask()

    for effect in effects:
        effect.resolve(args)

func rules_text() -> String:
    return "Buy 1 food for 1 gold, or vice versa"