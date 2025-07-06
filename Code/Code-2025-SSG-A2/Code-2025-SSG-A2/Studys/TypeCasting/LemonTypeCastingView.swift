//
//  LemonTypeCastingView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 7/6/25.
//

import SwiftUI

class LemonTypeCastingItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var price: Int

    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

class LemonTypeCastingFood: LemonTypeCastingItem {
    var foodType: String

    init(name: String, price: Int, foodType: String) {
        self.foodType = foodType
        super.init(name: name, price: price)
    }

    static var builtin: LemonTypeCastingFood {
        LemonTypeCastingFood(name: "치킨", price: 20000, foodType: "가공식품")
    }
}

class LemonTypeCastingClothing: LemonTypeCastingItem {
    var color: Color

    init(name: String, price: Int, color: Color) {
        self.color = color
        super.init(name: name, price: price)
    }

    static var builtin: LemonTypeCastingClothing {
        LemonTypeCastingClothing(name: "반팔 티셔츠", price: 10000, color: .red)
    }
}

struct LemonTypeCastingView: View {
    @State private var cart: [LemonTypeCastingItem] = [
        LemonTypeCastingFood.builtin,
        LemonTypeCastingClothing.builtin,
    ]

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(cart) { item in
                        ItemRowView(item: item)
                            .listRowBackground(
                                Color(.secondarySystemBackground)
                            )
                            .swipeActions {
                                Button(
                                    "삭제",
                                    systemImage: "trash",
                                    role: .destructive
                                ) {
                                    cart.removeAll(where: { $0.id == item.id })
                                }
                            }
                    }
                }
                .scrollContentBackground(.hidden)

                VStack {
                    totalItemsFooter
                        .padding()

                    addButton
                }
                .padding()
            }
            .navigationTitle("장바구니")
        }
    }

    private var totalItemsFooter: some View {
        VStack {
            HStack {
                Text("총 비용")
                    .font(.headline)

                Spacer()

                Text("\(cart.reduce(0, { $0 + $1.price }))원")
            }
            HStack {
                Text("총 개수")
                    .font(.headline)

                Spacer()

                Text("\(cart.count)개")
            }
        }
    }

    private var addButton: some View {
        Menu {
            Button("일반 상품") {
                let iphone = LemonTypeCastingItem(name: "아이폰", price: 1_490_000)

                cart.append(iphone)
            }
            Button("식품") {
                let food = LemonTypeCastingFood(
                    name: "콩나물",
                    price: 5000,
                    foodType: "야채류"
                )

                cart.append(food)
            }
            Button("의류") {
                let clothing = LemonTypeCastingClothing(
                    name: "청바지",
                    price: 29000,
                    color: .indigo
                )

                cart.append(clothing)

            }
        } label: {
            Label("추가하기", systemImage: "plus")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial, in: Capsule())
        }
    }

    private struct ItemRowView: View {
        let item: LemonTypeCastingItem

        var body: some View {
            HStack {
                HStack {
                    Text("\(item.name)")
                        .font(.headline)

                    switch item {
                    case let food as LemonTypeCastingFood:
                        Text("\(food.foodType)")
                            .font(.caption)
                    case let clothing as LemonTypeCastingClothing:
                        Circle()
                            .foregroundStyle(clothing.color)
                            .frame(maxWidth: 16)
                    default:
                        EmptyView()
                    }
                }
                Spacer()

                Text("\(item.price)원")
            }
        }
    }
}

#Preview {
    LemonTypeCastingView()
}
