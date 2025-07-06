//
//  LemonGenericView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 6/29/25.
//

import SwiftUI

private protocol LemonGenericStack {
    associatedtype Item
    var count: Int { get }
    mutating func push(_ item: Item)
    mutating func pop() -> Item?
}

private struct LemonGenericStackInt: LemonGenericStack {
    private var items: [Int] = []

    var count: Int { items.count }

    mutating func push(_ item: Int) {
        items.append(item)
    }

    mutating func pop() -> Int? {
        return items.popLast()
    }
}

private struct LemonGenericStackDouble: LemonGenericStack {
    private var items: [Double] = []

    var count: Int { items.count }

    mutating func push(_ item: Double) {
        items.append(item)
    }

    mutating func pop() -> Double? {
        return items.popLast()
    }
}

private func LemonGenericStackEqualSize<
    Stack1: LemonGenericStack,
    Stack2: LemonGenericStack
>(_ someStack: Stack1, _ anotherStack: Stack2) -> Bool
where Stack1.Item == Stack2.Item {
    someStack.count == anotherStack.count
}

struct LemonGenericView: View {
    @State private var float1: Float = 1.0
    @State private var float2: Float = 2.0

    @State private var stack1: LemonGenericStackInt = LemonGenericStackInt()
    @State private var stack2: LemonGenericStackInt = LemonGenericStackInt()
    @State private var stack3: LemonGenericStackDouble =
        LemonGenericStackDouble()

    var body: some View {
        VStack {
            VStack {
                Text("Generic Function")
                    .font(.headline)
                    .padding(.bottom)

                VStack {
                    Text("float1: \(float1)")
                    Text("float2: \(float2)")
                }
                .padding(.bottom)

                Button("Swap") {
                    swap(&float1, &float2)
                }
            }
            .padding()
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 16)
            )

            VStack {
                Text("Generic Where Clauses")
                    .font(.headline)
                    .padding(.bottom)

                HStack {
                    VStack {
                        Text("stack1(Int): \(stack1.count)")
                        Button("Push") {
                            stack1.push(0)
                        }
                        Button("Pop") {
                            _ = stack1.pop()
                        }
                    }

                    VStack {
                        Text("stack2(Int): \(stack2.count)")
                        Button("Push") {
                            stack2.push(0)
                        }
                        Button("Pop") {
                            _ = stack2.pop()
                        }
                    }

                    VStack {
                        Text("stack3(Double): \(stack3.count)")
                        Button("Push") {
                            stack3.push(0)
                        }
                        Button("Pop") {
                            _ = stack3.pop()
                        }
                    }
                }

                Text(
                    "Equal size: \(LemonGenericStackEqualSize(stack1, stack2))"
                )

                // Global function 'LemonGenericStackEqualSize' requires the types 'Int' and 'Double' be equivalent
                // Text("Equal size: \(LemonGenericStackEqualSize(stack1, stack3))")
            }
            .padding()
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 16)
            )
        }
    }

    private func swap<T>(_ a: inout T, _ b: inout T) {
        let temp = a
        a = b
        b = temp
    }
}

#Preview {
    LemonGenericView()
}
