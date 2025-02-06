import SwiftUI

struct BlockView: View {
    let block: Block
    let cellSize: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(block.isTarget ? Color.white : Color.yellow)
            if block.isTarget {
                Image(.mainBlock)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
            }
        }.frame(width: block.size.width * cellSize - 10, height: block.size.height * cellSize - 10)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: DeviceInfo.shared.deviceType == .pad ? 4:2)
            )
        
            .position(x: block.position.x * cellSize + (block.size.width * cellSize / 2),
                      y: block.position.y * cellSize + (block.size.height * cellSize / 2))
            
    }
}
