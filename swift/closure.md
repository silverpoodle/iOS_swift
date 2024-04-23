### Closure

- 이름없는 함수: {}
- 중괄호로 묶어서 이름을 지정하지 않고도 함수로 사용
- in 키워드를 사용해 인자와 반환값 타입을 분리해 사용

```swift
// 배열의 각 요소에 대해 주어진 클로저를 실행하여 새로운 배열을 리턴하는 map 함수를 사용하는 예시
let numbers = [10, 21, 30] 

let y = numbers.map(
	{
    (number: Int) -> Int in
		return 3 * number 
	}
)
print(y)
```

<br/>

결과:

```tex
[30, 63, 90]
```

<br/>

<br/>

### Option + click

![image](https://github.com/silverpoodle/iOS_swift/assets/88484476/8b982025-3fff-4beb-9b8f-ba93c510ef1b)




<br/>

<br/>

### Closure의 간결화

```swift
// 번호를 사용하여 클로저를 작성하는 예시
let numbers = [10, 20, 30]
var y = numbers.map({ number in 3 * number })

// 번호를 사용한 클로저의 더 간단한 형태
let numbers = [10, 20, 30]
var y = numbers.map({
    // $0: 클로저의 첫 번째 매개변수를 나타냅니다. (첫 번째 요소, 그 뒤로 $1, $2, ...)
    // 클로저 내에서는 매개변수 이름 대신에 번호로 참조
    3 * $0
})
```



