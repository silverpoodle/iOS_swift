### 흐름제어

- 조건문: if와 switch
- 반복문: for-in, for, while, repeat-while

```swift
var teamScore = 0
let score = 30

// if문
if score > 50 {
    teamScore = 3
} else {
    teamScore = 11
}
// if문의 조건은 반드시 불리언 표현이어야 함
// if (...)에서 괄호를 없애고 if ... 해도 됨

// 0 과 비교하지 않으면 에러!
let score = 30
if score {
    //에러!
}

// 기존 방식
if condition1 && condition2 {
    print("Both conditions are true")
} else {
    print("At least one condition is false")
}

// 변경된 방식
if condition1, condition2 {
    print("Both conditions are true")
} else {
    print("At least one condition is false")
}
```



<br/>

<br/>

### Switch

> case문은 자동적으로 빠져 나오기 때문에 코드 끝에 break 키워드를 명시하지 않아도 됨

```swift
let vegetable = "red pepper"
switch vegetable {
    case "celery":
        let vegetableComment = "Add some raisins and make ants on a log."
    case "cucumber", "watercress":
        let vegetableComment = "That would make a good tea sandwich."
    case let x where x.hasSuffix("pepper"):
        let vegetableComment = "Is it a spicy \(x)?"
    default:
        let vegetableComment = "Everything tastes good in soup."
}
// Default가 없으면 case로 모든 도메인을 커버해야 함
```



<br/>

<br/>

### for

#### 	1. for in range

```swift
var firstForLoop = 0
var range = 0..<5
for i in range {
    firstForLoop += i
}
print("firstForLoop=", firstForLoop)

var secondForLoop = 0
for _ in 1...5 {  // _를 사용하면 필요 없는 변수를 생성하지 않음
    secondForLoop += 1
}
print("secondForLoop=", secondForLoop)
```

<br/>

결과:

```tex
firstForLoop: 10
secondForLoop: 5
```



<br/>

#### 	2. for in Container

```swift
// 주어진 딕셔너리 interestingNumbers
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13], // 소수(Prime) 집합
    "Fibonacci": [1, 1, 2, 3, 5, 8], // 피보나치(Fibonacci) 집합
    "Square": [1, 4, 9, 16, 25], // 제곱수(Square) 집합
]

var largest = 0 // 가장 큰 숫자를 저장할 변수

// 딕셔너리에서 키와 값에 대해 반복(iterate)
for (_, numbers) in interestingNumbers {
    // 각 숫자 집합(numbers)에 대해 반복(iterate)
    for number in numbers {
        // 현재 숫자가 이전에 발견한 가장 큰 숫자(largest)보다 큰지 비교
        if number > largest {
            // 만약 현재 숫자가 가장 큰 숫자보다 크다면,
            // 현재 숫자를 가장 큰 숫자로 갱신
            largest = number
        }
    }
}s
```

<br/>

결과:

```tex
largest: 25
```

<br/>

<br/>

### while

```swift
var n = 2
while n < 100 {
    n = n * 2
}

var m = 2
repeat {
    m = m * 2
} while m < 100  // do-while 대신에 repeat-while를 사용함
```

<br/>

결과:

```tex
n: 128
m: 128
```

