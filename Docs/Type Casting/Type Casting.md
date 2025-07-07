>[!question]
>GQ1. Type Casting이란 무엇일까?
>GQ2. Type Casting을 언제 사용할까?
>GQ3. `Any`와 `AnyObject`는 무엇일까?

## Description

Type Casting은 런타임에 값의 타입을 확인하고 구체적인 타입 정보를 부여한다.

- 인스턴스의 타입을 확인하거나 해당 클래스의 상위 클래스나 하위 클래스로 취급하는 방법이다.
- Swift에서는 `is`와 `as` 연산자로 구현한다.
- 프로토콜 준수 여부를 확인할 수 있다.

## 주요 기능

### 1. 타입 확인

`is`를 사용하여 인스턴스가 특정 하위 클래스의 타입인지 확인할 수 있다.

타입의 여부만 확인하며 타입의 속성에는 접근할 수 없다.

```Swift
// 기본 클래스 정의
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

// 하위 클래스 정의
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// 인스턴스 배열 생성 - Swift는 자동으로 `[MediaItem]`으로 추론
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")
```

### 2. 다운 캐스팅

실제 인스턴스가 하위 클래스인 경우 `as`를 사용하여 다운 캐스트할 수 있다.

- `as?`는 옵셔널 값을 반환하며, 실패 시 `nil`이 되는 안전한 방식이다.
- `as!`는 강제 캐스팅으로, 캐스팅 실패 시 런타임 에러가 발생한다.

```Swift
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}
```

### 3. `Any` 및 `AnyObject`를 이용한 타입 캐스팅

특정 값이 아닌 값을 다룰 수 있는 타입

- `Any`는 함수를 포함한 모든 타입의 값을 나타낼 수 있다.
- `AnyObject`는 모든 클래스 타입의 인스턴스를 나타낼 수 있다.

필요한 경우에만 사용해야 하며, 가능하면 명확한 타입을 사용하는 것이 좋다.

```Swift
var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
```

> `Any`는 옵셔널 타입도 포함할 수 있다. `Any`가 기대되는 위치에 옵셔널 값을 직접 넣으면 경고가 발생한다. 이때, `as Any`를 사용하여 명시적으로 캐스팅할 수 있다.

```Swift
let optionalNumber: Int? = 3
things.append(optionalNumber)        // 경고 발생
things.append(optionalNumber as Any) // 경고 없음
```

## 코드 예시

```Swift
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
```

## Keywords

- [[Protocol]]
- [[Class]]

## References

- [Type Casting | Documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/typecasting)