import SwiftUI

struct LoadingView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            
            VStack {
                Spacer()
                Image(.lady1Position)
                    .resizable()
                    .scaledToFit()
                    
            }.ignoresSafeArea(edges: .bottom)
            
            VStack {
                Spacer()
                ZStack {
                    VStack {
                        ZStack {
                            Rectangle()
                                .padding(.horizontal)
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 62:31)
                                .cornerRadius(20)
                                .foregroundStyle(.loaderBg)
                            ProgressView(value: progress, total: 100)
                                .progressViewStyle(LinearProgressViewStyle())
                                .cornerRadius(20)
                                .accentColor(Color.mainRed)
                                .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 12:6)
                                
                                .scaleEffect(y: DeviceInfo.shared.deviceType == .pad ? 12.0:6.0, anchor: .center)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow, lineWidth: 1)
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 62:31)
                                }
                                .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 12:6)
                            
                            Text("Loading...")
                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16))
                                .foregroundStyle(.mainYellow)
                                .textCase(.uppercase)
                        }.frame(width: UIScreen.main.bounds.width / 2.5)
                        
                    }
                }
                .foregroundColor(.black)
                .padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 50:25)
            }
        }.background(
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                
        )
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    LoadingView()
}

