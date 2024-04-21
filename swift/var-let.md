### let (상수) & var(변수)

<img src="https://i.stack.imgur.com/js8g1.png" alt="What is the difference between `let` and `var` in Swift? - Stack Overflow" style="zoom:67%;" />

<br/>

```swift
/* let와 var */
// let을 사용하면 상수를 만들고 var를 사용하면 변수를 선언
var myVariable = 42 // 변수
myVariable += 42

let yourVariable = 42 // 상수
//yourVariable += 42 // 에러: 상수는 변경할 수 없음


/* 문자열 내 변수 값 삽입 */
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

<br/>

#### 결과:

```vb
myVariable: 84
yourVariable: 42

appleSummary: I have 3 apples.
fruitSummary: I have 8 pieces of fruit.
```

<br/>

<br/>

### implicit(암시적) & explicit(명시적)

<img src="https://github.com/silverpoodle/typora-images/blob/main/image-20240421202444294.png?raw=true" alt="image-20240421202444294.png" style="zoom:70%;" />

<br/>

```swift
/* 변수의 타입지정 */
// 변수의 타입을 명시적으로 지정하거나, 암시적으로 추론할 수 있음
// 암시적 지정의 경우, 오른쪽 값의 타입을 따라감
let explicitInt: Int = 70 // Int 타입으로 명시적으로 선언
let implicitInteger = 70 // Int 타입으로 추론
let implicitDouble = 70.5 // Double 타입으로 추론
let explicitDouble: Double = 70 // 명시적으로 Double 타입으로 선언
```

<br/>

#### 결과:

```vb
explicitInt: 70
implicitInteger: 70
implicitDouble: 70.5
explicitDouble: 70.0
```

<br/>

<br/>

### Type Casting (형변환)

```swift
/* 형변환 */
// 데이터 타입 간의 변환은 기본적으로 좌우 타입이 동일해야 함함
// 생성자를 호출하여 변환환
// 지원하는 타입: Int, UInt, Float, Double, String, Bool
let label = "The width is "
let width = 94

let widthLabel = label + String(width) // Int를 String으로 변환하여 문자열 연결

let height = Int("10") // "10"을 Int로 변환
let sheight = Int("10.5") // 부동 소수점 문자열은 Int로 변환할 수 없으므로 nil 반환
let dheight = Int(10.5) // 부동 소수점 숫자는 Int로 변환할 수 없음
```

<br/>

#### 결과:

```vb
widthLabel: The width is 94

height: 10
sheight: nil
dheight: nil
```



<br/>

<br/>

### Array (배열)

```swift
/* 배열 */
// 배열은 대괄호 []를 사용하여 생성
var list1: [Int] = [] // Int를 저장하는 빈 배열, 명시적 선언
var list2 = [Int]() // Int를 저장하는 빈 배열, 암시적 선언

var shoppingList = ["catfish", "water", "tulips", "blue paint"] // 배열 초기화, 암시적 선언
shoppingList[1] = "bottle of water" // 배열 요소에 접근하여 수정 가능
let first = shoppingList.first // 배열의 첫 번째 요소에 접근하여 가져옴 (Optional 타입)
```

<br/>

#### 결과:

```vb
list1: []
list2: []

shoppingList: ["catfish", "bottle of water", "tulips", "blue paint"]
first: Optional("catfish")
```



<br/>

<br/>

### Dictionary

```swift
/* 딕셔너리 */
// 딕셔너리는 key와 value 쌍으로 값을 저장하는 구조
var dict1: [String: Int] = [:] // <문자열, 값>으로 저장하는 빈 딕셔너리, 명시적 선언
var dict2 = [String: Int]() // <문자열, 값>으로 저장하는 빈 딕셔너리, 암시적 선언

var occupations = ["Malcolm": "Captain", "Kaylee": "Mechanic"] // 딕셔너리 초기화
occupations["Jayne"] = "Public Relations" // 딕셔너리에 새로운 요소 추가
let myjob = occupations["kjhan"] // 에러, 딕셔너리에 "kjhan" 키가 없으므로 nil 반환
```

<br/>

#### 결과:

```vb
dict1: [:]
dict2: [:]
occupations: ["Malcolm": "Captain", "Kaylee": "Mechanic", "Jayne": "Public Relations"]
myjob: nil
```

