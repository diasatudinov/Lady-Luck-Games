import SwiftUI

class GameViewModel: ObservableObject {
    @Published var blocks: [Block] = []
    @Published var gameOver: Bool = false
    let gridSize = 6
    let cellSize: CGFloat = DeviceInfo.shared.deviceType == .pad ? 100.0:50.0

    let levels: [[Block]] = [
        [// Целевая фигурка (движется только по горизонтали)
            Block(position: CGPoint(x: 1, y: 2), size: CGSize(width: 2, height: 1), isTarget: true, direction: .horizontal),
            // Другие блоки:
            Block(position: CGPoint(x: 0, y: 0), size: CGSize(width: 3, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 0, y: 1), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 0, y: 4), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 1, y: 1), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 1, y: 3), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 2, y: 4), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 2, y: 3), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 3, y: 0), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 4, y: 1), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 5, y: 1), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 4, y: 3), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 4, y: 4), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 5, y: 4), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
        ],
        
        [
            // Целевая фигурка (движется только по горизонтали)
            Block(position: CGPoint(x: 1, y: 2), size: CGSize(width: 2, height: 1), isTarget: true, direction: .horizontal),
            // Другие блоки:
            Block(position: CGPoint(x: 1, y: 0), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 2, y: 0), size: CGSize(width: 3, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 3, y: 1), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 4, y: 1), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 5, y: 2), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 3, y: 4), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 4, y: 5), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal)
            
        ],
        
        [
            // Целевая фигурка (движется только по горизонтали)
            Block(position: CGPoint(x: 0, y: 2), size: CGSize(width: 2, height: 1), isTarget: true, direction: .horizontal),
            // Другие блоки:
            Block(position: CGPoint(x: 0, y: 1), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 2, y: 0), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 3, y: 0), size: CGSize(width: 3, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 4, y: 1), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 4, y: 2), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 5, y: 2), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 0, y: 4), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 1, y: 3), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 3, y: 3), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 4, y: 4), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 4, y: 5), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
        ]
        
    ]
    
    init() {
        resetGame()
    }
    
    // Начальные установки игры
    func resetGame() {
        // Пример расстановки блоков:
        blocks = levels.randomElement() ?? [
            // Целевая фигурка (движется только по горизонтали)
            Block(position: CGPoint(x: 1, y: 2), size: CGSize(width: 2, height: 1), isTarget: true, direction: .horizontal),
            // Другие блоки:
            Block(position: CGPoint(x: 1, y: 0), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 2, y: 0), size: CGSize(width: 3, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 3, y: 1), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 4, y: 1), size: CGSize(width: 1, height: 2), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 5, y: 2), size: CGSize(width: 1, height: 3), isTarget: false, direction: .vertical),
            Block(position: CGPoint(x: 3, y: 4), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal),
            Block(position: CGPoint(x: 4, y: 5), size: CGSize(width: 2, height: 1), isTarget: false, direction: .horizontal)
        ]
        gameOver = false
    }
    
    // Перемещение блока на одну клетку (offset задается в единицах клеток)
    func moveBlock(_ block: Block, by offset: CGPoint) {
        guard let index = blocks.firstIndex(of: block) else { return }
        var newPos = block.position
        
        // Разрешаем движение только в указанном направлении
        if block.direction == .horizontal {
            newPos.x += offset.x
        } else {
            newPos.y += offset.y
        }
        
        // Проверяем, что блок остается в пределах поля
        if newPos.x < 0 || newPos.y < 0 ||
            newPos.x + block.size.width > CGFloat(gridSize) ||
            newPos.y + block.size.height > CGFloat(gridSize) {
            // Если целевая фигурка коснулась границы, считаем, что игрок выиграл
            if newPos.x + block.size.width > CGFloat(gridSize) {
                if block.isTarget {
                    gameOver = true
                }
            }
            return
        }
        
        // Проверка на столкновение с другими блоками
        let newRect = CGRect(origin: newPos, size: block.size)
        for other in blocks {
            if other.id == block.id { continue }
            let otherRect = CGRect(origin: other.position, size: other.size)
            if newRect.intersects(otherRect) {
                return
            }
        }
        
        // Если все проверки пройдены – обновляем позицию блока
        blocks[index].position = newPos
        
        // Дополнительная проверка: если целевая фигурка достигла правой границы поля, завершаем игру
        if block.isTarget, newPos.x + block.size.width == CGFloat(gridSize) {
            gameOver = true
        }
    }
}
