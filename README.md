# This & That

**This & That** is a pair-matching game for macOS, designed with SwiftUI. Flip cards, find matching emoji pairs, and test your memory on beautiful, animated game boards.

---

## Gameplay

- Select a **grid size** from the menu:  
  `2×2`, `4×4`, `6×6`, or `8×8`
- Press **Play** to start a new game.
- Flip over two cards:
  - If they match, they stay visible.
  - If they don’t, they flip back after a moment.
- The game ends once all pairs are found.

---

## Directory structure
```
This-and-That/
    ├── views/
    │   ├── MenuView.swift         # Start screen with grid selector
    │   ├── GameView.swift         # Main game logic and layout
    │   └── CardView.swift
    ├── viewModels/
    │   └── GameViewModel.swift
    ├── models/
    │   └── Card.swift
    └── ThisAndThat.swift          # App entry point
```