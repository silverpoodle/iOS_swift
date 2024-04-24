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

### 