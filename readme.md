# hex-deck

This is a prototype for a game about playing cards to place hex-tiles on a map.

Each card has a color and a structure (1-5 hex tiles, e.g. Ark Nova)

- Card Stats
  - Rarity
  - Sell / Buy Value
  - Name
  - Type
  - Effect

## Game Loop

- For round in range(5):
  - Draw hand of 5 cards
  - Play cards (cards are free)
- If food <= foodRequirement
- Win
- Draft another card
- Shop, etc.

## TODO

- Excel doc: [link](https://docs.google.com/spreadsheets/d/1TMEV-sFI3mOZJgG8Z5mYMCvU5P2x5S5duTnkkBkJ5sk/edit#gid=0)

- Refactor Effects. Consider these
  - Effect resolution
    - EffectArg types are too rigid.
      - Maybe I can consolidate around a single type, with some kind of variable binding method?
  - Maybe an effect registers itself on a card/structure. That way Envelop can plug into the intialization of the card, and also add its handlers
    - An effect would be able to "span" more than one trigger
  - Effect stack
    - If multiple effects trigger at the same time, they should be stacked ( maybe by the player, or by a set priority)

- Refactor map generation
  - More parameterized
  - More robust to the discovery mechanic, and new tile types
  - Consolidated (it's currently spread across Meta and Map)
  - Figure out how tileInfo gets generated for discovered tiles

- UI
  - Camera movement
  - Selected cards should be raised sligtly
  - Visualize Envelop mechanic

- Attribution
  - <a href="https://www.flaticon.com/free-icons/mountain" title="mountain icons">Mountain  icons created by Freepik - Flaticon</a>
  - <a href="https://www.flaticon.com/free-icons/wave" title="wave icons">Wave icons created by Ayub Irawan - Flaticon</a>
  - <a href="https://www.flaticon.com/free-icons/botanical" title="botanical icons">Botanical icons created by Nur syifa fauziah - Flaticon</a>


## Ideas

- Effects
  - Shop
  - Discovery
  - Spawn other tiles
  - Rotation
  - Splitting a structure
  - Sacrifice / Destroy

- Shop
  - Relics
  - Cards
  - Packs
  - Sell / Upgrade / Modify / Combine / Paint cards

- Non-player tiles  
  - Examples:
    - Herd animals
    - Barbarians

## Nice to have

- Pallette
- PARTICLES!
- Show which phase we're in
- Invalid placements
  - Show feedback on error
- Placement bonus
  - Effect
- Cards
  - Abilities

- IntervalEffects
  - Structures can have an interval effect
  - Tick down after each card play
  - Resolve an effect and reset countdown when it reaches 0

## Extra

- itch.io
  - Rename the game
  - Write a short description
  - Make a nice cover image (630x500)
  - Add screenshots (recommended: 3-5)
  - Pick a genre
  - Add a tag or two
  - Publish a devlog on instagram
