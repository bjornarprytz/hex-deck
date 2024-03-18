# hex-deck

This is a prototype for a game about playing cards to place hex-tiles on a map.

Each card has a color and a structure (1-5 hex tiles, e.g. Ark Nova)

Each color (red, blue, yellow, green, blue, purple) has a corresponding ability:

- Points for unique colors adjacent
- Points for same colors adjacent
- Draw card
- Just points
- Requirement: Adjacent to ocean
- Gold

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
  - if points < round.requirement:
    - Loss
- Win
- Draft another card
- Shop, etc.

## TODO

- Parameterize affinity placement rule (for terrain type)

- UI
  - Camera movement

- Extend the Create-class
  - Tiles
  - PlacedStructure

- Refactor Prompts
  - Streamline the prompts a little bit.
  - Consolidate factory functions
  - Remove the boilerplate from the factory functions
  - Make sure the UI works as intended.
  - Add a damping effect to hide the clutter
  - Special pick from-hand prompt?

- Refactor map generation
  - More parameterized
  - More robust to the discovery mechanic, and new tile types
  - Consolidated (it's currently spread across Meta and Map)

## Base Rules

- Placement
  - Border -> Adjacent
  - Impassable: Mountain / Water
  - No flipping tiles

- End of round (one hand)
  - Add food, eat food
  - Food requirements

- Placement Bonuses
  - On map or On card
  - Player can order the effects if needed

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
- Show Which phase we're in
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
