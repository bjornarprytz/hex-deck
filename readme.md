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

- Wire shit up
  - Finish effect implementations
  - Call adjacent placement effects when a structure is placed

- Remove Income
- Add Discard Pile
- List Cards in Draw-/DiscardPile
  - Card Summary

- Effects Overhaul
  - Keywords Only

- New Keywords
  - Convert X->Y
    - Change alignment
  - Retain
    - Don't discard card on end step
  - Banish
    - Remove card from Deck
  - Exile
    - Removed from DrawPile
  - Trading X
    - Banish X cards for 2F/1G each
  - Scout
    - Food per empty tile
  - Forage - 1 Food if on placement bonus
  - "Connected"
    - Chain of Adjacency
  - Fishing X
    - Mill X, Effect based on the set of cards
  - OnAdjacentPlacement
    - Track
  - Wild color (Choose upon placement)

- Sub misssions
  - Take all placement bonuses
  - Reward: 3 Food

---

- Figure out how tileInfo gets generated for discovered tiles

- Refactor map generation
  - More parameterized
  - More robust to the discovery mechanic, and new tile types
  - Consolidated (it's currently spread across Meta and Map)

- UI
  - Camera movement
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
