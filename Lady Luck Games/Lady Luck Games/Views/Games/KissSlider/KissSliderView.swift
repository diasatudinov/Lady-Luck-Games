import SwiftUI
import AVFoundation

struct KissSliderView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = GameViewModel()
    @StateObject var settingsVM = SettingsViewModel()
    @State private var counter: Int = 0
    @State private var pauseShow: Bool = false
    @State private var audioPlayer: AVAudioPlayer?

    
    
    var body: some View {
        ZStack {
            HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
                VStack {
                    Spacer()
                    Image(.lady2Position)
                        .resizable()
                        .scaledToFit()
                        .opacity(0)
                }
                ZStack {
                    // Игровое поле со светлой сеткой и границей
                    GridView(gridSize: viewModel.gridSize, cellSize: viewModel.cellSize)
                        .overlay(
                            Rectangle()
                            .stroke(Color.yellow,
                                    style: StrokeStyle(lineWidth: DeviceInfo.shared.deviceType == .pad ? 6:3, dash: [7]))
                        )
                    
                    // Отрисовка блоков
                    ForEach(viewModel.blocks) { block in
                        BlockView(block: block, cellSize: viewModel.cellSize)
                            .gesture(
                                DragGesture(minimumDistance: DeviceInfo.shared.deviceType == .pad ? 20:10)
                                    .onEnded { gesture in
                                        // Определяем направление движения по оси в зависимости от разрешенного направления
                                        let threshold: CGFloat = DeviceInfo.shared.deviceType == .pad ? 60:30
                                        if block.direction == .horizontal {
                                            let move: CGFloat = gesture.translation.width > threshold ? 1 : (gesture.translation.width < -threshold ? -1 : 0)
                                            if move != 0 {
                                                viewModel.moveBlock(block, by: CGPoint(x: move, y: 0))
                                                if settingsVM.soundEnabled {
                                                    playSound(named: "llgMove")
                                                }
                                            }
                                        } else {
                                            let move: CGFloat = gesture.translation.height > threshold ? 1 : (gesture.translation.height < -threshold ? -1 : 0)
                                            if move != 0 {
                                                viewModel.moveBlock(block, by: CGPoint(x: 0, y: move))
                                                if settingsVM.soundEnabled {
                                                    playSound(named: "llgMove")
                                                }
                                            }
                                        }
                                    }
                            )
                    }
                }.frame(width: CGFloat(viewModel.gridSize) * viewModel.cellSize,
                        height: CGFloat(viewModel.gridSize) * viewModel.cellSize)
                
                VStack {
                    Spacer()
                    Image(.lady2Position)
                        .resizable()
                        .scaledToFit()
                        .opacity(viewModel.gameOver ? 0:1)
                }
                
            }.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        pauseShow = true
                    } label: {
                        ZStack {
                            Image(.pause)
                                .resizable()
                                .scaledToFit()
                            
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    Spacer()
                }
                Spacer()
            }.padding()
            
            if pauseShow {
                ZStack{
                    Color.black.opacity(0.5).ignoresSafeArea()
                    VStack {
                        
                        Text("Pause")
                            .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 72:36))
                            .foregroundStyle(.yellow)
                            .textCase(.uppercase)
                        
                        Button {
                            pauseShow = false
                        } label: {
                            Text("Resume")
                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64:32))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                                .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 28:14)
                                .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 160:80)
                                .background(
                                    Color.mainRed
                                )
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow, lineWidth: 1)
                                )
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("  Menu  ")
                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64:32))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                                .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 28:14)
                                .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 160:80)
                                .background(
                                    Color.mainRed
                                )
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow, lineWidth: 1)
                                )
                        }
                    }
                    .padding(DeviceInfo.shared.deviceType == .pad ? 40:20)
                    .background(
                        Color.loaderBg
                    )
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.yellow, lineWidth: 1)
                    )
                }
                
            }
            
            if viewModel.gameOver {
                
                
                ZStack{
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    if counter < 2 {
                        VStack(spacing: 0) {
                            Spacer()
                            Text("Congratulations!")
                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 96:48))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                            Image(.lady1Position)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 640:320)
                        }.ignoresSafeArea()
                    } else {
                        VStack {
                            Button {
                                viewModel.resetGame()
                            } label: {
                                Text("Retry ")
                                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64:32))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                    .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 28:14)
                                    .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 160:80)
                                    .background(
                                        Color.mainRed
                                    )
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text(" Menu")
                                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64:32))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                    .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 28:14)
                                    .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 160:80)
                                    .background(
                                        Color.mainRed
                                    )
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                            }
                        }
                        .padding(DeviceInfo.shared.deviceType == .pad ? 40:20)
                        .background(
                            Color.loaderBg
                        )
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.yellow, lineWidth: 1)
                        )
                    }
                }
                .onAppear {
                    startTimer()
                }
            }
            
        }.background(
            Image(.bg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if counter < 2 {
                withAnimation {
                    counter += 1
                }
            } else {
                timer.invalidate()
            }
        }
    }
    
    func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    KissSliderView()
}

struct BoardBorderWithGap: Shape {
    let gridSize: Int
    let cellSize: CGFloat
    let gapCell: CGPoint  // gapCell.x не используется, gapCell.y определяет вертикальное положение щели
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Верхняя граница
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        // Правая граница с щелью:
        // Определяем вертикальные координаты щели. Например, если gapCell.y == 1, то щель будет от cellSize * 1 до cellSize * 2.
        let gapStartY = gapCell.y * cellSize
        let gapEndY = (gapCell.y + 1) * cellSize
        
        // Рисуем правую границу сверху до начала щели.
        path.addLine(to: CGPoint(x: rect.maxX, y: gapStartY))
        
        // Пропускаем область щели: перемещаем перо без рисования линии.
        path.move(to: CGPoint(x: rect.maxX, y: gapEndY))
        
        // Рисуем правую границу от конца щели до нижнего правого угла.
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // Нижняя граница
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Левая граница
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}
