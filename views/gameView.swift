import SwiftUI

struct GameView: View {
    @StateObject private var vm: GameViewModel
    @State private var gridAppeared = false
    let grid: GridSize
    let onGameOver: () -> Void

    init(grid: GridSize, onGameOver: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: GameViewModel(grid: grid))
        self.grid = grid
        self.onGameOver = onGameOver
    }

    private let spacing: CGFloat       = 4
    private let outerPadding: CGFloat  = 8
    private let buttonHeight: CGFloat  = 40
    private let animationDelay: Double = 0.4

    var body: some View {
        GeometryReader { geo in
            let cols            = grid.columns.count
            let rows            = Int(ceil(Double(vm.cards.count) / Double(cols)))
            let availableWidth  = geo.size.width  - outerPadding*2 - CGFloat(cols - 1)*spacing
            let availableHeight = geo.size.height - outerPadding*2 - buttonHeight
                                   - CGFloat(rows - 1)*spacing

            let edge = max(20,
                           min(availableWidth / CGFloat(cols),
                               availableHeight / CGFloat(rows)))

            VStack(spacing: 0) {
                Spacer(minLength: outerPadding)

                LazyVGrid(columns: grid.columns,
                          alignment: .center,
                          spacing: spacing) {
                    ForEach(vm.cards) { card in
                        CardView(card: card)
                            .frame(width: edge, height: edge)
                            .onTapGesture { vm.choose(card) }
                            .transition(.opacity)
                    }
                }
                .padding(.horizontal, outerPadding)

                Spacer(minLength: outerPadding)

                Button(action: {
                    withAnimation(.easeInOut(duration: animationDelay)) {
                        gridAppeared = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                        onGameOver()
                    }
                }) {
                    Text("Quit to Menu")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 0.96, blue: 0.80),
                                    Color(red: 1.0, green: 0.80, blue: 0.80)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0.8, x: 0, y: 0)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, outerPadding)
            }
            .opacity(gridAppeared ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.4)) {
                    gridAppeared = true
                }
            }
            .onChange(of: vm.isGameOver) {
                if vm.isGameOver {
                    withAnimation(.easeInOut(duration: animationDelay)) {
                        gridAppeared = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
                        onGameOver()
                    }
                }
            }
        }
        .frame(minWidth: 350, minHeight: 350)
    }
}