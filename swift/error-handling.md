### 에러 처리

- 에러 발생시키는 함수 사용

  ```swift
  func canThrowErrors() throws -> String
  // 반드시 try 사용 해야 함.
  ```

  ```swift
  do {
      try expressions
      statements
  } catch pattern1 {
      statements
  } catch pattern2 where condition {
      statements
  } 
  
  //축약
  try? expression //error = nil
  try! Expression //error 없는게 확신될 경우에만
  ```

  <br/>

ex)

```swift
// VendingMachine 클래스는 자판기를 나타내며, 
// vend 메서드를 통해 물건을 판매하고 에러를 처리
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    // 물건을 판매하는 메서드
    func vend(itemNamed name: String) throws {
        // 재고 확인
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        // 재고가 있는지 확인
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        // 가격 확인
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        print("Dispensing \(name), coinsDeposited: \(coinsDeposited)")
    }
}

// VendingMachineError 열거형은 자판기 오류를 정의한다.
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// Item 구조체는 물건의 가격과 재고 수량을 나타낸다.
struct Item {
    var price: Int
    var count: Int
}

// VendingMachine 인스턴스를 생성하고, 자판기에 동전을 넣은 후 Chips를 구매하는 예제
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 32

do {
    try vendingMachine.vend(itemNamed: "Chips")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Dispensing Chips, coinsDeposited:22

// try?를 사용하여 Chips를 구매하고 결과를 옵셔널로 받음
let x = try? vendingMachine.vend(itemNamed: "Chips")
print(x) // Dispensing Chips, coinsDeposited:12 & ()

// try!를 사용하여 Candy Bar를 강제로 구매
let y = try! vendingMachine.vend(itemNamed: "Candy Bar")
print(y) // Dispensing Candy Bar, coinsDeposited:0 & ()

// try?를 사용하여 Pretzels를 구매하고 결과를 옵셔널로 받음
let z = try? vendingMachine.vend(itemNamed: "Pretzels")
print(z) // nil, 그러나 프로그램은 죽지 않는다

// try!를 사용하여 Pretzels를 강제로 구매, 하지만 잔액 부족으로 인해 런타임 에러 발생
let w = try! vendingMachine.vend(itemNamed: "Pretzels")
print(w)

```

