import SwiftUI

struct DashboardView: View {
    @ObservedObject var matchManager: MatchManager
    @State private var levelPoints: Double = 250
    private let maxPoints: Double = 500

    var levelProgress: Double {
        levelPoints / maxPoints
    }

    @State private var showHelpSheet = false
    @State private var selectedPage = 0
    @State private var navigateToPrivateRoom = false
    @State private var navigateToLeaderboard = false
    @State private var navigateToMyCards = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(#colorLiteral(red: 0.1000694409, green: 0.3843396008, blue: 0.5841861963, alpha: 1)),
                        Color(#colorLiteral(red: 0.039, green: 0.584, blue: 0.741, alpha: 1))
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 50, height: 50)
                                        .shadow(radius: 9)

                                    Text("\(Int(levelPoints))")
                                        .foregroundColor(.blue)
                                        .fontWeight(.bold)
                                }

                                VStack(alignment: .leading, spacing: 6) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LinearGradient(
                                                gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            ))
                                            .frame(width: 160, height: 24)

                                        Text("\(Int(levelPoints)) / \(Int(maxPoints))")
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.black)
                                    }
                                }
                            }

                            Button(action: {
                                print("Coin button tapped")
                            }) {
                                HStack(spacing: 8) {
                                    Text("25000")
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.yellow)
                                        .cornerRadius(30)

                                    Image("coins")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                }
                            }
                        }

                        Spacer()

                        VStack(spacing: 5) {
                            HStack(spacing: 12) {
                                Button(action: {
                                    navigateToLeaderboard = true
                                }) {
                                    Image("winner")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                                Button(action: {
                                    navigateToMyCards = true
                                }) {
                                    Image("card_16271793")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                                Button(action: {
                                    print("store tapped")
                                }) {
                                    Image("store_869636")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                            }

                            VStack(spacing: 5) {
                                Button(action: {
                                    print("Ghost tapped")
                                }) {
                                    Image("ghost")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }

                                Text("0")
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                            Button(action: {
                                showHelpSheet = true
                            }) {
                                HStack(spacing: 4) {
                                    Text("تعلم اللعب")
                                        .foregroundColor(.yellow)
                                        .font(.footnote)
                                        .lineLimit(1)

                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.yellow)
                                        .font(.footnote)
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 4)
                                .background(Color.cyan.opacity(0.3))
                                .cornerRadius(8)
                            }
                            .frame(width: 140, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal)

                    Spacer()

                    VStack(spacing: -19) {
                        Image("Preview")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200)
                            .cornerRadius(20)

                        Button(action: {
                            print("✅ Start button tapped")
                            matchManager.startMatchmaking()
                        }) {
                            ZStack {
                                Text("ابدأ اللعب !")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.black)
                                    .offset(x: 1, y: 1)

                                Text("ابدأ اللعب !")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.red)
                            }
                            .frame(width: 330, height: 25)
                            .padding()
                            .background(
                                Capsule()
                                    .fill(matchManager.authenticationState != .authenticated || matchManager.inGame ?
                                          Color.gray : Color.yellow)
                            )
                        }
                        .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
                    }

                    Text(matchManager.authenticationState.rawValue)
                        .font(.headline.weight(.bold))
                        .foregroundColor(.secondary)

                    NavigationLink(destination: ContentView1(), isActive: $navigateToPrivateRoom) {
                        EmptyView()
                    }
                    .padding()

                    NavigationLink(destination: LeaderBoard(), isActive: $navigateToLeaderboard) {
                        EmptyView()
                    }
                    .padding()

                    NavigationLink(destination: MyCardsView(), isActive: $navigateToMyCards) {
                        EmptyView()
                    }
                    .padding()

                    Button(action: {
                        navigateToPrivateRoom = true
                    }) {
                        Text("أنشئ غرفة خاصة")
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                            .background(Color(#colorLiteral(red: 0.0, green: 0.741, blue: 0.839, alpha: 1)))
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
                .padding()
                .overlay(
                    Group {
                        if showHelpSheet {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()

                            VStack {
                                ZStack(alignment: .topTrailing) {
                                    TabView(selection: $selectedPage) {
                                        ForEach(0..<4) { index in
                                            helpPage(index: index)
                                                .tag(index)
                                        }
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                                    .frame(width: 330, height: 390)
                                    .background(Color(#colorLiteral(red: 0.0, green: 0.58, blue: 0.74, alpha: 1)))
                                    .cornerRadius(25)
                                    .shadow(radius: 10)

                                    Button(action: {
                                        showHelpSheet = false
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                    .padding(10)
                                }
                            }
                            .transition(.scale)
                        }
                    }
                )
            }
        }
    }

    func helpPage(index: Int) -> some View {
        let titles = ["كيفية اللعب", "خلّك قريب من أصحابك", "في بداية اللعب", "الأكشن كاردز"]
        let descriptions = [
            "اجمع شبحك، وافتح عيونك! تقدر تعرف عدد أوراق خصمك وتخطط بذكاء",
            "وادخلوا الغرفة كفريق واحد — التحدي يبدأ لما تكونون مجتمعين!",
            "في بداية اللعب، كل لاعب راح يحصل على 12 ورقة. الهدف؟ خلّص أوراقك بأسرع ما يمكن! أول لاعب يخلّص أوراقه يحجز المركز الأول، والبقية يتنافسون على باقي المراكز حسب الترتيب",
            "اختر بطاقتين(اكشن كاردز) قبل ما تبدأ اللعب… قراراتك الآن ممكن تغيّر مجرى الجولة! وبعد ما تلعب 6 أوراق، اللعبة تتغير — عندك 3 ثواني بس تختار بسرعة وحدة من بطاقتك، وتوجّهها للخصم المناسب. لحظة وحدة ممكن ترفعك أو تطيحك!"
        ]
        let images = ["ghost", "table", "places", "card_16271793"]

        return VStack(spacing: 16) {
            Text(titles[index])
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text(descriptions[index])
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)

            Image(images[index])
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 150)
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(matchManager : MatchManager())
    }
}
