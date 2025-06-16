import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .shadow(radius: 1)
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 1.0, green: 0.96, blue: 0.80),
                                Color(.systemIndigo)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing),
                            lineWidth: 2
                    )
                Text(card.content).font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 1.0, green: 0.96, blue: 0.80),
                                Color(.systemIndigo)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .animation(.easeInOut, value: card.isFaceUp)
    }
}