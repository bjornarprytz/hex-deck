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

- Sub misssions
  - Take all placement bonuses
  - Reward: 3 Food

---

- Figure out how tileInfo gets generated for discovered tiles

- Refactor
  - Effect resolution
    - EffectArg types are too rigid.
      - Maybe I can consolidate around a single type, with some kind of variable binding method?

- Refactor map generation
  - More parameterized
  - More robust to the discovery mechanic, and new tile types
  - Consolidated (it's currently spread across Meta and Map)

- UI
  - Camera movement
  - Sub mission progress
  - Show Milled Cards
    - Milled cards should be Cards (not just CardData)
  - Selected cards should be raised sligtly
  - Differentiate terrain and structures more

- Effect stack
  - If multiple effects trigger at the same time, they should be stacked ( maybe by the player, or by a set priority)

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
