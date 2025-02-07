import SwiftUI

struct GamesView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settingsVM: SettingsViewModel
    
    @State private var showGame1 = false
    @State private var showGame2 = false
    @State private var showGame3 = false
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Spacer()
                    Image(.lady1Position)
                        .resizable()
                        .scaledToFit()
                }.ignoresSafeArea(edges: [.horizontal, .bottom])
                VStack {
                    VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15) {
                        
                        Button {
                            showGame1 = true
                        } label: {
                            TextBg(text: "Memory Kiss", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                        }
                        
                        
                        Button {
                            showGame2 = true
                        } label: {
                            TextBg(text: "Kiss SLide", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                        }
                        
                        
                        
                        Button {
                            showGame3 = true
                        } label: {
                            TextBg(text: "Love cube", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                        }
                        
//                        if DeviceInfo.shared.deviceType == .pad {
//                            Spacer()
//                        }
                    }
                    
                }
                VStack {
                    Spacer()
                    Image(.lady1Position)
                        .resizable()
                        .scaledToFit()
                        .opacity(0)
                }
            }
            
            VStack {
                ZStack {
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Image(.backLLG)
                                    .resizable()
                                    .scaledToFit()
                                
                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                            
                        }
                        Spacer()
                    }.padding([.leading, .top])
                }
                Spacer()
            }
            
        }.background(
            Image(.bg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        .fullScreenCover(isPresented: $showGame1) {
            MemoryKiss(settingsVM: settingsVM)
        }
        .fullScreenCover(isPresented: $showGame2) {
            KissSliderView()
        }
        .fullScreenCover(isPresented: $showGame3) {
            LoveCube()
        }
    }
}

#Preview {
    GamesView(settingsVM: SettingsViewModel())
}
