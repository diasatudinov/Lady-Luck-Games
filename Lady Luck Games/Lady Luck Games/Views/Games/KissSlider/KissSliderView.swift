import SwiftUI

struct KissSliderView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = GameViewModel()
    @State private var counter: Int = 0
    @State private var pauseShow: Bool = false

    var body: some View {
        ZStack {
            HStack(spacing: 20) {
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
                                .stroke(Color.yellow, lineWidth: DeviceInfo.shared.deviceType == .pad ? 4:2)
                        )
                    
                    // Отрисовка блоков
                    ForEach(viewModel.blocks) { block in
                        BlockView(block: block, cellSize: viewModel.cellSize)
                            .gesture(
                                DragGesture(minimumDistance: 10)
                                    .onEnded { gesture in
                                        // Определяем направление движения по оси в зависимости от разрешенного направления
                                        let threshold: CGFloat = 30
                                        if block.direction == .horizontal {
                                            let move: CGFloat = gesture.translation.width > threshold ? 1 : (gesture.translation.width < -threshold ? -1 : 0)
                                            if move != 0 {
                                                viewModel.moveBlock(block, by: CGPoint(x: move, y: 0))
                                            }
                                        } else {
                                            let move: CGFloat = gesture.translation.height > threshold ? 1 : (gesture.translation.height < -threshold ? -1 : 0)
                                            if move != 0 {
                                                viewModel.moveBlock(block, by: CGPoint(x: 0, y: move))
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
                                .padding(.vertical, 14)
                                .padding(.horizontal, 80)
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
                                .padding(.vertical, 14)
                                .padding(.horizontal, 80)
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
                    .padding(20)
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
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 80)
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
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 80)
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
                        .padding(20)
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
}


#Preview {
    KissSliderView()
}




