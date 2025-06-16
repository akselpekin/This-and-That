import SwiftUI

enum GridSize: String, CaseIterable, Identifiable {
    case twoByTwo = "2 × 2"
    case fourByFour = "4 × 4"
    case sixBySix = "6 × 6"
    case eightByEight = "8 × 8"

    var id: String { rawValue }

    var pairCount: Int {
        switch self {
        case .twoByTwo:  return 2
        case .fourByFour: return 8
        case .sixBySix:  return 18
        case .eightByEight: return 32
        }
    }

    var columns: [GridItem] {
        let side: Int
        switch self {
        case .twoByTwo:  side = 2
        case .fourByFour: side = 4
        case .sixBySix:  side = 6
        case .eightByEight: side = 8
        }
        return Array(repeating: GridItem(.flexible()), count: side)
    }
}

@MainActor
final class GameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    private var indexOfFirstFaceUp: Int?
    private let emojiSource = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐸🐵🐔🐧🐦🐤🐺🦄🐝🐞🦂🦋🐢🐍🦖🐙🦑🐳🐬🦈"

    init(grid: GridSize) { startNewGame(grid) }

    func startNewGame(_ grid: GridSize) {
        let emojis = Array(emojiSource.prefix(grid.pairCount))
        let contents = (emojis + emojis).shuffled()
        cards = contents.map { Card(content: String($0)) }
        indexOfFirstFaceUp = nil
    }

    func choose(_ card: Card) {
        guard let chosenIdx = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIdx].isFaceUp,
              !cards[chosenIdx].isMatched
        else { return }

        cards[chosenIdx].isFaceUp = true

        if let firstIdx = indexOfFirstFaceUp {
            if cards[firstIdx].content == cards[chosenIdx].content {
                cards[firstIdx].isMatched = true
                cards[chosenIdx].isMatched = true
            } else {
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    cards[firstIdx].isFaceUp = false
                    cards[chosenIdx].isFaceUp = false
                }
            }
            indexOfFirstFaceUp = nil
        } else {
            indexOfFirstFaceUp = chosenIdx
        }
    }

    var isGameOver: Bool { cards.allSatisfy(\.isMatched) }
}