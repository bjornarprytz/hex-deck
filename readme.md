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

- Rules explanation (TAB)

- Placement
  - Check terrain
  - Show error

## Refactor

- Context object for the game actions (to avoid arg bloat)
- Move at least some of the card play logic into structure placement
  - Validate placement based on Color
- Inherit structure preview logic (_add_hex, hex_spawner, etc.)
  - Mind the centroid in structurePreview.gd

## Nice to have

- Show Which phase we're in
- Invalid placements
  - Show feedback on error
- Placement bonus
  - Effect
- Cards
  - StructureViewer
    - put border around the whole
  - Abilities

### Chores


- Push release with `./push_release.sh`

### Extra

- itch.io
  - Rename the game
  - Write a short description
  - Make a nice cover image (630x500)
  - Add screenshots (recommended: 3-5)
  - Pick a genre
  - Add a tag or two
  - Publish a devlog on instagram
