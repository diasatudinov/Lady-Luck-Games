
import SwiftUI

struct LoveCube: View {
    @Environment(\.presentationMode) var presentationMode

    let diceImages = ["win", "dice1", "dice2"]
    
    @State private var currentImage: String = "dice1"
    @State private var timer: Timer? = nil
    @State private var gameFinished: Bool = false
    @State private var pauseShow: Bool = false

    @State private var counter: Int = 0

    var body: some View {
        ZStack {
            HStack {
                
                VStack {
                    Spacer()
                    Image(.lady2Position)
                        .resizable()
                        .scaledToFit()
                        .opacity(0)
                }
                
                VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
                    // Display the dice image
                    Image(currentImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: DeviceInfo.shared.deviceType == .pad ? 320:160, height: DeviceInfo.shared.deviceType == .pad ? 320:160)
                    
                    
                    Button {
                        startTimer()
                    } label: {
                        Text("Roll the dice")
                            .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                            .foregroundStyle(.yellow)
                            .textCase(.uppercase)
                            .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 24:12)
                            .frame(width: DeviceInfo.shared.deviceType == .pad ? 492:244)
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
                .padding(DeviceInfo.shared.deviceType == .pad ? 66:33)
                .background(
                    Color.mainRed
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow, lineWidth: 1)
                )
                
                VStack {
                    Spacer()
                    Image(.lady2Position)
                        .resizable()
                        .scaledToFit()
                        .opacity(gameFinished ? 0:1)
                }.ignoresSafeArea()
                
            }
            
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
            
            if gameFinished {
                
                
                ZStack{
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    if counter < 2 {
                        
                        VStack(spacing: 0) {
                            Spacer()
                            if currentImage == "win" {
                                Text("Congratulations!")
                                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 96:48))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                Image(.lady1Position)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 640:320)
                            } else {
                                Text("You lose!")
                                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 96:48))
                                    .foregroundStyle(.yellow)
                                    .textCase(.uppercase)
                                    .offset(y: 40)
                                Image(.lady3Position)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 640:320)
                            }
                        }.ignoresSafeArea()
                    } else {
                        VStack {
                            Button {
                                gameFinished = false
                                
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
                    gameOverTimer()
                }
            }
        }.background(
            Image(.bg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        
        
    }
    
    func startTimer() {
        timer?.invalidate()
        gameFinished = false
        // Create a timer that changes the dice image every 0.1 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            currentImage = diceImages.randomElement() ?? "dice1"
        }
        
        // Stop the timer after 2 seconds and mark game as finished
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            timer?.invalidate()
            timer = nil
            gameFinished = true
        }
    }
    
    private func gameOverTimer() {
        counter = 0
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
    LoveCube()
}
