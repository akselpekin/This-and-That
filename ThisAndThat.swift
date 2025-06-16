import SwiftUI

@main
struct ThisAndThatApp: App {
    enum AppState: Equatable { case menu, playing(grid: GridSize) }
    @State private var state: AppState = .menu

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(.systemTeal)
                    .ignoresSafeArea()
                switch state {
                case .menu:
                    MenuView { chosenSize in
                        withAnimation {
                            state = .playing(grid: chosenSize)
                        }
                    }
                    .transition(.move(edge: .trailing))

                case .playing(let grid):
                    GameView(grid: grid) {
                        withAnimation {
                            state = .menu
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.4), value: state)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}