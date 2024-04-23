### Optional

- 컴파일 순간에 값이 정해지지 않는 경우

```swift
var anumber = Int("10") // 문자열 "10"을 정수로 변환하여 anumber에 저장
// Int("10")은 실행하기 전에 "10"이 정수로 변환될 수 있을지 모름
// Int() 함수의 반환 타입: Int? => 리턴 값은 정수 or nil
// 따라서 anumber의 데이터 타입은 Int?

var bnumber = Int("10.0")
// Int("10.0")는 "10.0"가 정수가 될 수 없으므로 nil을 리턴. Int(10.0)
print(anumber) // Optional(10)를 출력한다
print(bnumber) // nil을 출력한다.

// 타입 불일치로 인한 에러 발생 예시
// var cnumber: Int = Int("10") // 에러 발생, 옵셔널 타입과 일반 타입의 할당 불일치
// var dnumber: Int = Int("10.0") // 에러 발생, 옵셔널 타입과 일반 타입의 할당 불일치
```

결과:

```tex
10
nil
```

<br/>

### 변수/상수 선언

- **일반(Type)**: 일반 값을 저장할수 있으나 절대 nil값은 저장할수 없다
-  Optional(Type?): 일반 값과 nil값을 저장할 수 있다.
- **Implicit Unwrapping Optional(Type!)**: 일시적으로 nil을 가질수 있으나 read되기 전에 반드시 일반 값이 저장되어야 한다.

```swift
// 타입 불일치로 인한 에러 발생 예시
/ Optional 변수의 선언
var anumber: Int = 10 // 일반 타입
var bnumber: Int? = 20 // 옵셔널 타입
var cnumber: Int! // 암시적 언래핑 옵셔널
var dnumber: Int! // 암시적 언래핑 옵셔널

// 암시적 언래핑 옵셔널을 사용한 예시
cnumber = 20
anumber = cnumber // 암시적 언래핑 옵셔널은 최초의 reading 전에 일반값으로 초기화되어야 함
dnumber = bnumber // 옵셔널 값이 nil일 수 있으므로 초기화는 필요하지 않음
anumber = dnumber // 문제 없음

// dnumber가 nil이 됨
dnumber = nil

// dnumber가 nil이므로 암시적 언래핑 옵셔널의 값이 nil이 아닌 것을 가정할 때 에러 발생
anumber = dnumber  //런타임 에러 발생
var cnumber: Int = Int("10") // 에러 발생, 옵셔널 타입과 일반 타입의 할당 불일치
// var dnumber: Int = Int("10.0") // 에러 발생, 옵셔널 타입과 일반 타입의 할당 불일치
```

결과:

```tex
anumber=20
bnumber=Optional(20)
cnumber=20
dnumber=nil
```

<br/>

### Forced Unwrapping (강제 언래핑)

- Optional 변수의 값을 일반 변수의 값으로 변환
- 변수의 값이 nil이 아니면 일반값으로 변환 
- 변수의 값이 nil인 경우 에러

```swift
// Forced Unwrapping (강제 언래핑)
var anumber: Int = 10 // 일반 타입
var bnumber: Int? = 20 // 옵셔널 타입
var cnumber: Int! // 암시적 언래핑 옵셔널
var dnumber: Int! // 암시적 언래핑 옵셔널

anumber = bnumber // 문법 에러
anumber = bnumber! // 옵셔널 값의 강제 언래핑
bnumber = anumber // 에러 발생하지 않음
```

<br/>

### Optional: If Statements

-  nil인지 아닌지 if문을 사용하여 체크

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // convertedNumber의 데이터 타입은 Int?

if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber).")
    // Optional(123)을 출력
}
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
    // 123을 출력
}
```

<br/>

### Optional Binding

- If Statements + Forced Unwrapping

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // convertedNumber의 데이터 타입: Int?
if let actualNumber = convertedNumber {
    // 이 블록 내에서만 actualNumber이 유효함
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
    print("The string \"\(possibleNumber)\" has an integer value of \(convertedNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}

```

결과:

```tex
The string "123" has an integer value of 123
The string "123" has an integer value of Optional(123)
```

<br/>

### Multple optional binding

- If문안에서 comma로 분리하여 여러 개를 binding

```swift
func compareTwoNumbers(first: String, second: String) -> String {
    if let firstNumber = Int(first), let secondNumber = Int(second) {
        // 이 블록 내에서만 firstNumber, secondNumber가 유효함
        if firstNumber < secondNumber && secondNumber < 100 {
            return "\(firstNumber) < \(secondNumber) < 100"
        }
    }
    return "error"
}
print(compareTwoNumbers(first: "10", second: "42"))
```

결과:

```tex
10 < 42 < 100
```

<br/>

### Optional binding - guard

- 옵셔널 바이딩중 하나라도 nil이면 else로 빠져나옴

```swift
func compareTwoNumbers(first: String, second: String) -> String {
    guard let firstNumber = Int(first), let secondNumber = Int(second) else {
        return "error"
    }
    // 이 이후에만 firstNumber, secondNumber가 유효함
    if firstNumber < secondNumber && secondNumber < 100 {
        return "\(firstNumber) < \(secondNumber) < 100"
    }
    return "error"
}
print(compareTwoNumbers(first: "10", second: "42"))
```

결과:

```tex
10 < 42 < 100
```

<br/>

### Optional Chaining

- 옵셔널 변수를 사용하여 하위 프로퍼티, 메소드, 스브스크립트 등을 액세스할 때 
  옵셔널 변수가 nil인 경우 액세스 없이 결과를 nil로 함
- 액세스 하고자하는 프로퍼티, 메소드, 스브스크립트에 `?` 를 붙여서 표시

```swift
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

// nil을 강제 언래핑하여 에러
let roomCount1 = john.residence!.numberOfRooms // 런타임 에러 발생

// 옵셔널 체이닝 사용
let roomCount2 = john.residence?.numberOfRooms 

// residence가 nil이므로 numberOfRooms에 접근하지 않고 nil을 반환
print(roomCount2)
```

결과:

```tex
nil
```

<br/>

### Optional Chaining

- 옵셔널 변수를 사용하여 하위 프로퍼티, 메소드, 스브스크립트 등을 액세스할 때 
  옵셔널 변수가 nil인 경우 액세스 없이 결과를 nil로 함
- 액세스 하고자하는 프로퍼티, 메소드, 스브스크립트에 `?` 를 붙여서 표시

```swift
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

// nil을 강제 언래핑하여 에러
let roomCount1 = john.residence!.numberOfRooms // 런타임 에러 발생

// 옵셔널 체이닝 사용
let roomCount2 = john.residence?.numberOfRooms 

// residence가 nil이므로 numberOfRooms에 접근하지 않고 nil을 반환
print(roomCount2)
```

결과:

```tex
nil
```

<br/>

`※ 여러 레벨로 옵셔널 체이닝이 적용되는 경우 `
`– xxx?.yyy?.zzz? : 이 경우 xxx, yyy, zzz중 하나라도 nil이면 전체 결과가 nil`

```swift
class Person {
    var residence: Residence?
}

class Residence {
    var address: Address?
}

class Address {
    var city: String
    
    init(city: String) {  // 초기화 메서드
        self.city = city  // 초기화 메서드를 통해 도시 속성을 설정
    }
}

let john = Person()

// john의 residence가 nil이므로 옵셔널 체이닝이 적용됩니다.
let city = john.residence?.address?.city

print(city) // 출력 결과: nil
```