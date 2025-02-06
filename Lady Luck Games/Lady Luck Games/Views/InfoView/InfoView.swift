//
//  InfoView.swift
//  Lady Luck Games
//
//  Created by Dias Atudinov on 06.02.2025.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var ruleIndex = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    Spacer()
                    HStack(spacing: 0) {
                        VStack {
                            Spacer()
                            Image(ruleIndex == 2 ? .lady1Position:.lady2Position)
                                .resizable()
                                .scaledToFit()
                                .opacity(ruleIndex == 2 ? 1:0)
                        }
                        
                        switch ruleIndex {
                        case 0:
                            ruleView(image: "infoImage1", text: "Memory Kiss – Find matching cards (heels, lipstick, handbag, etc.). Win to receive a blown kiss from Lady Luck", imageHeight: DeviceInfo.shared.deviceType == .pad ? 92:46)
                        case 1:
                            ruleView(image: "infoImage2", text: "Move the blocks to free the kiss-shaped cube. Complete the puzzle to proceed", imageHeight: DeviceInfo.shared.deviceType == .pad ? 212:106)
                        case 2:
                            ruleView(image: "infoImage3", text: "Roll the dice. A kiss means victory! An X means \"Try again\"", imageHeight: DeviceInfo.shared.deviceType == .pad ? 190:95)
                        default:
                            ZStack {
                                
                            }
                        }
                        
                       
                        VStack {
                            Spacer()
                            Image(ruleIndex == 2 ? .lady1Position:.lady2Position)
                                .resizable()
                                .scaledToFit()
                                .opacity(ruleIndex == 2 ? 0:1)
                        }
                    }
                }
                
                VStack {
                    ZStack {
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.backLLG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }.padding(DeviceInfo.shared.deviceType == .pad ? 60:30)
                
            }.ignoresSafeArea(edges: [.horizontal, .bottom])
            .background(
                Image(.bg)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
            )
        }
    }
    
    @ViewBuilder func ruleView(image: String, text: String, imageHeight: CGFloat) -> some View {
        
        
        HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
            
            VStack(alignment: .center, spacing: DeviceInfo.shared.deviceType == .pad ? 20:10) {
                
                Text(text)
                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.yellow)
                    .textCase(.uppercase)
                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 588:294)
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: imageHeight)
                
                HStack {
                    
                    if ruleIndex > 0 {
                        Button {
                            if ruleIndex > 0 {
                                withAnimation {
                                    ruleIndex -= 1
                                }
                            }
                        } label: {
                            Text("Back")
                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
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
                    
                    if ruleIndex < 2 {
                        Button {
                            if ruleIndex < 2 {
                                withAnimation {
                                    ruleIndex += 1
                                }
                            }
                        } label: {
                            Text("Next")
                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
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
                }
            }.padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 40:20)
                .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 16:8)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 83/255, green: 11/255, blue: 11/255),
                        Color(red: 137/255, green: 20/255, blue: 10/255),
                        Color(red: 83/255, green: 11/255, blue: 11/255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.yellow, lineWidth: 1)
            )
            
        }
    }
}


#Preview {
    InfoView()
}
