struct Block: Identifiable, Equatable {
    let id = UUID()
    var position: CGPoint
    var size: CGSize
    var isTarget: Bool
    var direction: Axis
}