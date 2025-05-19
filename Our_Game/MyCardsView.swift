import SwiftUI

struct ActionCard: Identifiable {
    let id = UUID()
    let image: String
    let count: Int
    let label: String
    let description: String?
}

struct MyCardsView: View {

    @Environment(\.dismiss) var dismiss

    let actionCards: [ActionCard] = [
        ActionCard(image: "Group2", count: 1, label: "تجميد", description: ""),
        ActionCard(image: "Group4", count: 1, label: "تكرار", description: "\n"),
        ActionCard(image: "Group5", count: 2, label: "حماية", description: "\n"),
       // ActionCard(image: "Group5", count: 2, label: "حماية", description: "\n"),
       // ActionCard(image: "Group4", count: 1, label: "تكرار", description: "\n")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(#colorLiteral(red: 0.09, green: 0.55, blue: 0.74, alpha: 1)),
                        Color(#colorLiteral(red: 0.08, green: 0.38, blue: 0.58, alpha: 1))
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(alignment: .trailing, spacing: 20) {

                    // Top bar
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 20, height: 30)
                                .foregroundColor(.white)
                                .padding(.leading)
                        }

                        Spacer()
                    }

                    // Title & Description
                    VStack(alignment: .trailing, spacing: 6) {
                        HStack(spacing: 6) {
                            Text("بطاقاتي ")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Image("card-game")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }

                        Text("بطاقات تمنح اللاعب قدرات تكتيكية أو مفاجئة تؤثر مباشرة على مجريات اللعب\nاضغط على البطاقة لمعرفة وظيفتها")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(2)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    // Scrollable card area
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 40) {
                            ForEach(actionCards) { card in
                                CardView(image: card.image, count: card.count, label: card.label, description: card.description)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(#colorLiteral(red: 0.07, green: 0.65, blue: 0.85, alpha: 1)))
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 6, y: 6)
                        )
                        .padding(.horizontal)
                    }

                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct CardView: View {
    var image: String
    var count: Int
    var label: String
    var description: String?

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .topTrailing) {
                Image(image)
                    .resizable()
                    .frame(width: 120, height: 145)
                    .cornerRadius(15)

                if count > 0 {
                    Text("\(count)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .frame(width: 20, height: 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .offset(x: -8, y: 8)
                }

                VStack {
                    Spacer()
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                        .shadow(radius: 1)
                }
                .frame(width: 100, height: 140)
            }

            if let desc = description {
                Text(desc)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 90)
            }
        }
    }
}

#Preview {
    MyCardsView()
}
