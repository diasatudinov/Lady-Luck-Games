import SwiftUI

struct MemoryKiss: View {
    @ObservedObject var settingsVM: SettingsViewModel
    
    @State private var cards: [Card] = []
    @State private var selectedCards: [Card] = []
    @State private var message: String = "Find all matching cards!"
    @State private var gameEnded: Bool = false
    @State private var pauseShow: Bool = false
    private let cardTypes = ["card1", "card2", "card3", "card4", "card5", "card6", "card7", "card8"]
    private let gridSize = 4
    
    @State private var counter: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Spacer()
                    Image(.lady1Position)
                        .resizable()
                        .scaledToFit()
                        .opacity(0)
                }
                VStack {
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 10) {
                        ForEach(cards) { card in
                            CardView(card: card)
                                .onTapGesture {
                                    flipCard(card)
                                    if settingsVM.soundEnabled {
                                        // playSound(named: "flipcard")
                                    }
                                }
                                .opacity(card.isMatched ? 0.5 : 1.0)
                        }
                        
                    }
                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 900:460)
                    
                }
                .padding(14)
                .background(
                    Color.mainRed
                )
                .cornerRadius(10)
                .onAppear {
                    setupGame()
                }
                
                VStack {
                    Spacer()
                    Image(.lady2Position)
                        .resizable()
                        .scaledToFit()
                        .opacity(gameEnded ? 0:1)
                }
            }.ignoresSafeArea(edges: [.bottom, .trailing, .leading])
            
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
            
            if gameEnded {
                
                
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
                                setupGame()
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
            
        }
        .background(
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
    
    private func setupGame() {
        // Reset state
        selectedCards.removeAll()
        message = "Find all matching cards!"
        gameEnded = false
        
        // Generate cards
        var gameCards = [Card]()
        
        // Add 4 cards of each type (24 cards total for 6 types)
        for type in cardTypes {
            gameCards.append(Card(type: type))
            gameCards.append(Card(type: type))
        }
        
        // Add 1 semaphore card to make it 25 cards
        // gameCards.append(Card(type: "cardSemaphore"))
        
        // Shuffle cards
        gameCards.shuffle()
        
        // Ensure exactly 25 cards
        cards = Array(gameCards.prefix(gridSize * gridSize))
    }
    
    private func flipCard(_ card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched,
              selectedCards.count < 2 else { return }
        
        // Flip card
        cards[index].isFaceUp = true
        selectedCards.append(cards[index])
        
        if card.type == "cardSemaphore" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                resetAllCards()
            }
        } else if selectedCards.count == 2 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let allMatch = selectedCards.allSatisfy { $0.type == selectedCards.first?.type }
        
        if allMatch {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isMatched = true
                }
            }
            message = "You found a match! Keep going!"
        } else {
            message = "Not a match. Try again!"
        }
        
        // Flip cards back over after a delay if they don't match
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isFaceUp = false
                }
            }
            selectedCards.removeAll()
            
            // Check if all cards are matched
            if cards.allSatisfy({ $0.isMatched || $0.type == "cardSemaphore" }) {
                message = "Game Over! You found all matches!"
                gameEnded = true
                
            }
        }
    }
    
    private func resetAllCards() {
        message = "Red semaphore! All cards reset!"
        for index in cards.indices {
            cards[index].isFaceUp = false
            
            cards[index].isMatched = false
            
        }
        selectedCards.removeAll()
    }
    
    //    func playSound(named soundName: String) {
    //        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
    //            do {
    //                audioPlayer = try AVAudioPlayer(contentsOf: url)
    //                audioPlayer?.play()
    //            } catch {
    //                print("Error playing sound: \(error.localizedDescription)")
    //            }
    //        }
    //    }
}

#Preview {
    MemoryKiss(settingsVM: SettingsViewModel())
}
