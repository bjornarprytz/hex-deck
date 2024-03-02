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

- Game Loop
  - State machine
    - Draw 5
      - Play: Click/Click+Drag
        - Confirm Target: Click/Drop
        - Rotate Structure: Wheel
        - Cancel: RightClick/Drop on invalid target
      - Pass
    - EndCondition(points > requirement)
- Resolve Card Effect
- Deck
  - Add/Remove card
  - UI
- Hand
  - Add/Remove card
  - UI

## Nice to have

- Placement bonus
  - Effect
- Cards
  - StructureViewer
    - put border around the whole
  - Abilities

### Chores

- Import the project into Godot
- Setup itch.io page for hex-deck [link](https://itch.io/game/new)
  - Set Kind to HTML
  - Set viewport dimensions (normal: 1280x720)
  - Check SharedArrayBuffer
  - Hit the Save button
- Get Butler API key from [itch.io](https://itch.io/user/settings/api-keys)
- Publish github repo
- Add key to GitHub secrets as BUTLER_API_KEY [link](https://github.com/bjornarprytz/hex-deck/settings/secrets/actions)
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
