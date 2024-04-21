### Function

-  func를 사용해 함수를 선언
- 함수를 호출할 때는 함수의 이름과 괄호 안에 인자들을 넣어 호출
- 반환값의 타입은 '->'를 사용하여 함수 정의에서 명시

```swift
func greet(name: String, day: String) -> String { //반환값이 없는 경우 -> 생략 또는 Void
    return "Hello \(name), today is \(day)."
}

greet(name: "Bob", day: "Tuesday") // 호출
greet(day: "Tuesday", name: "Bob") // 순서가 바뀌면 에러


func greet(from name: String, _ day: String) -> String {
    return "Hello \(name), today is \(day)."
}

greet(from: "Bob", "Tuesday") // 두번째 전달 매개변수가 생략
greet(from: "Bob", day: "Tuesday")) // 매개변수로 호출 시 에러
```



<br/>

결과:

```tex
Hello Bob, today is Tuesday.
```



<br/>

<br/>

### 배열 인자

```swift
 // 배열을 이용하여 여러 개의 값을 함수의 인자로 받을 수 있음
func sumOf(numbers: Int...) -> Int { 
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

func sumOf1(numbers: [Int]) -> Int{
    var sum = 0
    for number in numbers {
    	sum += number
    }
    return sum
}

sumOf(numbers: 42, 597, 12)
sumOf1(numbers: [42, 597, 12])
```

<br/>

결과:

```tex
651
```

<br/>

<br/>



### 중첩 함수

```swift
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

// 중첩 함수는 감싸고 있는 함수에서 선언된 변수에 접근할 수 있음

returnFifteen()
```

<br/>

결과:

```tex
15
```



<br/>

<br/>

### first class type (최상위 타입)

- 함수도 다른 객체들에 일반적으로 적용 가능한 연산을 지원하는 객체
- 함수도 매개변수로 받을 수 있고, 다른 함수를 반환 값 형태로 반환

```swift
func makeIncrementer() -> (Int) -> Int {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}

// 함수 반환 값으로 함수를 받아서 사용
var increment = makeIncrementer()
print(increment(7))
```

<br/>

결과:

```tex
8
```

<br/>


```swift
// 함수 정의: hasAnyMatches
// 리스트와 조건 함수를 받아서 리스트에 포함된 요소 중 조건 함수를 만족하는지 확인하는 함수
// 리스트의 각 요소를 순회하면서 조건 함수를 적용하고, 조건을 만족하는 요소가 있는 경우 true를 반환
// 조건을 만족하는 요소가 없는 경우 false를 반환
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

// 함수 정의: lessThanTen
// 주어진 숫자가 10보다 작은지를 확인하는 함수
func lessThanTen(number: Int) -> Bool {
    return number < 10
}

// 주어진 리스트에서 10보다 작은 요소가 있는지 확인하는 함수 호출
var numbers = [20, 19, 7, 12]
let result = hasAnyMatches(list: numbers, condition: lessThanTen)

// 결과 출력
print(result)
```

<br/>

결과:

```tex
true
```