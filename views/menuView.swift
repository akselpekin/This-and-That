import SwiftUI

struct MenuView: View {
    @State private var selected = GridSize.fourByFour
    let onPlay: (GridSize) -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("This & That")
                .font(.system(size: 120, weight: .heavy))
                .overlay(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.96, blue: 0.80),
                            Color(.systemIndigo)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .mask(
                    Text("This & That")
                        .font(.system(size: 120, weight: .heavy))
                )

            Picker("Grid size", selection: $selected) {
                ForEach(GridSize.allCases) { size in
                    Text(size.rawValue).tag(size)
                }
            }
            .pickerStyle(.segmented)
            .padding(4)
            .frame(width: 260)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.96, blue: 0.80),
                        Color(.systemIndigo)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Button(action: { onPlay(selected) }) {
                Text("Play")
                    .shadow(color: .black, radius: 0.8, x: 0, y: 0)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 1.0, green: 0.96, blue: 0.80),
                                Color(red: 0.80, green: 1.0, blue: 0.80)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(PlainButtonStyle())
            .keyboardShortcut(.defaultAction)

        }
        .padding(40)
        .frame(minWidth: 400, minHeight: 300)
    }
}