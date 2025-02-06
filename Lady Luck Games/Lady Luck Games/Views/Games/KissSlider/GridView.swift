import SwiftUI

struct GridView: View {
    let gridSize: Int
    let cellSize: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<gridSize, id: \.self) { x in
                HStack(spacing: 0) {
                    ForEach(0..<gridSize, id: \.self) { y in
                        Rectangle()
                            .stroke(Color.yellow, lineWidth: 2)
                            .frame(width: cellSize, height: cellSize)
                            .background(
                                
                                (x + y) % 2 == 0 ?  Color.boardColor1 : .boardColor2
                                
                            )
                            .shadow(radius: x == 2 && y == 5 ? 4: 0, x: x == 2 && y == 5 ? 10: 0)
                            
                    }
                }
            }
        }
    }
}
