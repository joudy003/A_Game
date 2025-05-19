import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    let rank: Int
    var name: String?
}

struct LeaderBoard: View {
    @State private var players: [Player] = []
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            
            
            GeometryReader { geometry in
                ZStack {
                    // الخلفية
                    RadialGradient(
                        gradient: Gradient(colors: [.centerColor, .edgeColor]),
                        center: .center,
                        startRadius: 20,
                        endRadius: 500
                    )
                    .ignoresSafeArea()
                    
                    // العنوان
                    VStack {
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .bold()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 85)
                            }
                            
                            Text("لوحة الفائزين")
                                .font(.custom("SF Arabic Rounded", size: 30))
                                .foregroundColor(.white)
                                .bold()
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                    // كل المحتوى السفلي
                    VStack(spacing: 10) {
                        // المراكز 1-3
                        HStack(alignment: .bottom, spacing: 0) {
                            if let player = players.first(where: { $0.rank == 2 }) {
                                playerColumn(player: player, height: 170, rank: "2")
                            }
                            
                            if let player = players.first(where: { $0.rank == 1 }) {
                                VStack(spacing: 10) {
                                    VStack(spacing: 4) {
                                        Image("crown")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        
                                        Text(player.name ?? "شهد")
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    
                                    columnBlock(height: 230, rank: "1")
                                }
                            }
                            
                            if let player = players.first(where: { $0.rank == 3 }) {
                                playerColumn(player: player, height: 130, rank: "3")
                            }
                        }
                        
                        // المربع الأحمر
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 350, height: 3)
                            .padding(.top, -10)
                        
                        // الجزء الأبيض
                        ZStack {
                            RoundedRectangle(cornerRadius: 50, style: .continuous)
                                .fill(Color.white)
                                .frame(height: 400)
                                .ignoresSafeArea(edges: .bottom)
                            
                            ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(players.filter { $0.rank >= 4 && $0.rank <= 10 }) { player in
                                        HStack {
                                            // ✅ صورة الرانك وفي وسطها رقم المتغير
                                            ZStack {
                                                Image("rank")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                                
                                                Text("1")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 20))
                                                    .offset(y: -4)
                                            }
                                            .padding(.leading, 10)
                                            
                                            // اسم اللاعب
                                            Text(player.name ?? "saud")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                                .padding(.leading, 180)
                                            
                                            Spacer()
                                            
                                            // المربع اللي فيه الترتيب أيضاً (ممكن تزيله لو صار مكرر)
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color.orangeBlock)
                                                    .frame(width: 60, height: 60)
                                                
                                                Text("\(player.rank)")
                                                    .font(.title)
                                                    .bold()
                                                    .foregroundColor(.white)
                                            }
                                            .padding(.trailing, 20)
                                        }
                                        .offset(y: -50)
                                    }
                                }
                                .padding(.top, 50)
                            }
                            .frame(height: 300)
                        }
                    }
                    .frame(width: geometry.size.width)
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 300)
                }
            }
            .onAppear {
                fetchPlayers()
            }
        }.navigationBarBackButtonHidden()
    }
        
        func playerColumn(player: Player, height: CGFloat, rank: String) -> some View {
            VStack(spacing: 10) {
                Text(player.name ?? "الجوهرة")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                columnBlock(height: height, rank: rank)
            }
        }
        
        func columnBlock(height: CGFloat, rank: String) -> some View {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 110, height: 3)
                
                ZStack(alignment: .top) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.orangeBlock)
                            .frame(width: 55, height: height)
                        Rectangle()
                            .fill(Color.yellowBlock)
                            .frame(width: 55, height: height)
                    }
                    Text(rank)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 30)
                }
            }
        }
        
        func fetchPlayers() {
            players = [
                Player(rank: 1, name: "norah"),
                Player(rank: 2, name: nil),
                Player(rank: 3, name: "soso"),
                Player(rank: 4, name: nil),
                Player(rank: 5, name: nil),
                Player(rank: 6, name: nil),
                Player(rank: 7, name: nil),
                Player(rank: 8, name: nil),
                Player(rank: 9, name: nil),
                Player(rank: 10, name: nil)
            ]
        }
    
}

#Preview {
    LeaderBoard()
}
