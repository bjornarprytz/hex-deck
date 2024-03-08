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

- Restart button
- Playtest

- Make structures more visible

- Stage 1
  - An NPT with movement
  - Food
    - Increases each round
    - Income from structures
  - Placement bonuses
  - Discovery
  - Needs
    - Cards with effects
    - Starting Decks

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

- Effects
  - Shop
  - Discovery
  - Spawn other tiles

- Shop
  - Relics
  - Cards
  - Sell / Upgrade / Modify / Combine / Paint cards

## Extra

- Non-player tiles
  - Movement (X)
    - Decrease X when playing card
    - At tick 0, it moves
  - Interacting with other tiles
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
  - StructureViewer
    - put border around the whole
  - Abilities

### Extra

- itch.io
  - Rename the game
  - Write a short description
  - Make a nice cover image (630x500)
  - Add screenshots (recommended: 3-5)
  - Pick a genre
  - Add a tag or two
  - Publish a devlog on instagram
