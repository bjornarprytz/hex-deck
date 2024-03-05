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

- Execute Refactor plan

- Restart button

- Placement
  - Check terrain
  - Show error

## Refactor

- Context object for the game actions (to avoid arg bloat)
- Move at least some of the card play logic into structure placement
  - Validate placement based on Color
- Inherit structure preview logic (_add_hex, hex_spawner, etc.)
  - Mind the centroid in structurePreview.gd

### Refactor Plan

- Find a way to share the code that visualizes a structure
  - StructurePlacement
  - PreviewStructure
- Meta game state (meta.tscn)
  - Gold, deck, cards unlocked, etc
  - Card Pool (very ad hoc for now)
- Game Loop (main.tscn)
  - Score, Turn Sequence
  - UI
  - Manage game objects (Deck, hand, cards, etc.)
- Consolidate card play logic (structure_placement.tscn)
  - Handle user input
  - Placement of structure (point and rotate)
  - Feedback to the user (invalid placement)
  - Validate action (card, target, rotation)
  - Confirm action (card, target, rotation)
- Separate out the Card Resolution so it can easily be swapped out and changed

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

### Extra

- itch.io
  - Rename the game
  - Write a short description
  - Make a nice cover image (630x500)
  - Add screenshots (recommended: 3-5)
  - Pick a genre
  - Add a tag or two
  - Publish a devlog on instagram
