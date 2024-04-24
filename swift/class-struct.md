 ### Class

-  클래스를 만들기 위해서는 클래스 이름과 함께 class 키워드를 사용
- 속성을 선언하기 위해서는 상수나 변수를 선언하는 것과 똑같은 방식을 사용
- 메서드와 함수도 선언할 수 있음
- 'new' 키워드가 없이 인스턴스를 생성

```swift
// Shape 클래스 정의
class Shape {
    var numberOfSides = 0
    
    // 간단한 설명을 반환하는 메서드
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

// Shape 클래스의 인스턴스 생성
var shape = Shape()

// 인스턴스의 속성 값 설정
shape.numberOfSides = 7

// simpleDescription() 메서드 호출하여 결과 출력
var shapeDescription = shape.simpleDescription()
print(shapeDescription)
```

<br/>

결과:

```swift
A shape with 7 sides.
```

<br/>

<br/>

### 생성자 & 파괴자

```swift
// 초기화자(생성자)를 이용한 NamedShape 클래스 정의
class NamedShape {
    var numberOfSides: Int = 0 // 도형의 변의 수
    var name: String // 도형의 이름
    
    // 초기화자(생성자) 정의
    init(name: String) {
        self.name = name // name 속성 초기화
    }
    
    // 도형의 간단한 설명 반환하는 메서드
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//파괴자 – deinit 키워드 사용
```

<br/>

결과:

```swift
A shape with 0 sides.
```

<br/>

<br/>



### override

```swift
// Square 클래스 정의 - NamedShape 클래스 상속
class Square: NamedShape {
    var sideLength: Double // 정사각형의 한 변의 길이
    
    // 초기화자(생성자) 정의
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name) // 부모 클래스의 초기화자 호출
        numberOfSides = 4 // 변의 수 설정
    }
    
    // 정사각형의 면적을 계산하는 메서드
    func area() -> Double {
        return sideLength * sideLength
    }
    
    // 부모 클래스의 simpleDescription 메서드 오버라이드
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

// Square 클래스 인스턴스 생성 및 동작 확인
let test = Square(sideLength: 5.2, name: "my test square")
test.area() // 정사각형의 면적 계산
test.simpleDescription() // 정사각형의 간단한 설명 반환

```

<br/>

결과:

```tex
// 정사각형의 면적을 계산하여 출력
27.040000000000003

// 정사각형의 간단한 설명을 반환하여 출력
A square with sides of length 5.2.
```

<br/>

<br/>

### getter & setter

```swift
 
class EquilateralTriangle: NamedShape { var sideLength: Double = 0.0 init(sideLength: Double, name: String) {
self.sideLength = sideLength super.init(name: name) numberOfSides = 3
// sideLength는 저장프로퍼티
}
var perimeter: Double { // perimeter을 연산 프로퍼티라함
get {
return 3.0 * sideLength
}
set {
sideLength = newValue / 3.0 }
}
override func simpleDescription() -> String {
return "An equilateral triagle with sides of length \(sideLength)." }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter // call get
triangle.perimeter = 9.9 // call set
triangle.sideLength
```

<br/>

<br/>

### Enumerations

```swift
// 열거형 Rank 정의
enum Rank: Int {
    case Ace = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten // 실제값을 갖는 케이스들
    case Jack, Queen, King // 다른 케이스들
    // 간단한 설명을 반환하는 메서드
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

// Rank 열거형의 케이스와 실제값 확인
let ace = Rank.Ace
let aceRawValue = ace.rawValue

================================================================================================

//실제값(rawValue) - 실제값이 의미있는 경우가 아니라면 굳이 첫번째 값을 제공할 필요x
// 열거형 Suit 정의
enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    
    // 간단한 설명을 반환하는 메서드
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}

// Suit 열거형의 케이스와 간단한 설명 확인
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()
```

<br/>

결과:

```json
print(ace) // 출력: Ace
print(aceRawValue) // 출력: 1
print(heartsDescription) // 출력: hearts
```

<br/>

<br/>

### Struct

```swift
// 구조체 Card 정의
struct Card {
    var rank: Rank // 카드의 숫자 또는 랭크
    var suit: Suit // 카드의 모양
    
    // 간단한 설명을 반환하는 메서드
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

// Card 구조체 인스턴스 생성 및 동작 확인
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
var clone = threeOfSpades

clone.suit = .Diamonds

print(threeOfSpades.simpleDescription()) // "The 3 of spades"
print(clone.simpleDescription()) // "The 3 of diamonds"
```



<br/>

<br/>

### Protocol

- 자바에서 interface와 같다
- 메소드외 프로퍼티도 가능
  - {get} -> 하위 클래스 구조체에서 var, let를 모두 할 수 있음
  - {get set} -> 하위 클래스 구조체에서 var만 모두 할 수 있음

```swift
// 프로토콜 ExampleProtocol 정의
protocol ExampleProtocol {
    var simpleDescription: String { get } // 간단한 설명을 반환하는 프로퍼티
    // 조정하는 메서드
    mutating func adjust()
}

// 클래스 SimpleClass 정의 - ExampleProtocol 프로토콜 채택
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class." // 간단한 설명을 담는 프로퍼티
    var anotherProperty: Int = 69105 // 다른 속성
    
    // 설명을 조정하는 메서드
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}

var a = SimpleClass() // SimpleClass 인스턴스 생성
a.adjust() // adjust 메서드 호출

let aDescription = a.simpleDescription // 간단한 설명 확인

print(aDescription) // "A very simple class. Now 100% adjusted."
```

<br/>

<br/>

### Extension

- 기존의 타입들에 새로운 메서드나 속성들을 추가
- 기존 존재하는 기능을 재정의 할 수는 없음
- 연산 프로퍼티, 메소드, 이니셜라이저 등을 추가할 수 있음
- 프로퍼티는 안됨 (static이나 연산프로퍼티는 가능)

```swift
// ToString 프로토콜 정의
protocol ToString {
    func toString() -> String
}

// Date 타입에 ToString 프로토콜을 확장하여 toString() 메서드 구현
extension Date: ToString {
    static let dateFormatter = DateFormatter()
    
    func toString() -> String {
        Date.dateFormatter.dateFormat = "yyyy-MM-dd"
        return Date.dateFormatter.string(from: self)
    }
}

// 현재 날짜를 생성하고 toString() 메서드를 호출하여 문자열로 변환하여 출력
let now = Date()
print(now.toString())
```



<br/>

결과:

```json
2024-04-24
```

