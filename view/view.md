# 📱View

### 뷰(View)는 사용자 인터페이스의 기본 구성 요소이다.

-> 화면에 표시되는 버튼, 레이블, 이미지, 입력 필드 등의 모든 요소는 뷰다.

<br/>



## View Hierarchy

<img src="https://www.oreilly.com/api/v2/epubs/9780133491876/files/View/Wikipedia.png" alt="The View Hierarchy - iOS Programming: The Big Nerd Ranch Guide [Book]" style="zoom:80%;" />

<br/>

1. 모든 앱은 하나의 UIWindow 인스턴스를 가진다. 
2. 앱의 여러 뷰들은 이 UIWindow 인스턴스 내 포함된다.
3. 각 계층 구조의 뷰는 자신을 레이어(CALayer)에 그린다.
4. 모든 뷰의 레이어들은 전체 화면에 합성되며 하나의 화면이 그려진다.

<br/>

> **❓CALayer 란?**
>
> UIView가 그려질 때 UIView 자체가 아닌 내부 Layer(기본적으로 CALayer로 구성)에 그려진다.
> 즉 Layer는 View의 layer라는 이름으로 접근할 수 있는 **Property**이고 
> View는 Layer에게 CALayerDelegate을 수행할 수 있는 **Delegate**이다.

<br/>

<br/>



## UIViewController Lifecycle

<img src="https://miro.medium.com/v2/resize:fit:500/1*4IRtH9cYssCdmqh_qkzMWQ.png" alt="UIViewController LifeCycle. iOS 앱을 개발하면서 상당히 중요한 부분이고, 잘 알고 사용해야… | by Aske  | Medium" style="zoom:67%;" />

- `init`: 생성자 
- `loadView`: 스토리보드 등을 이용하여 View Hierarchy를 완성 (코딩 X)
- **`viewDidLoad`: View가 화면에 나오기전에 초기화 등** 
- `viewWillAppear`: 화면에 보이기 직전에 호출되는 함수로 여기서 UI layout등을 조정 
- `viewDidAppear`: 화면이 보이는 상태, 여기서부터 사용자와 인터렉션이 가능 
- `viewWillDisappear`: 화면이 보이지 않게 되는 시점에서 호출, (코딩 X)
- `viewDidDisappear`: 화면이 사라진후에 호출됨, 통상적으로 저장되어야 하는 데이터가 있다면 저장



<br/><br/>

## ✏️Review

1. ViewController 생성 시 : new file -> **Cocoa Touch Class** 
<img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/b9c6740e-b191-4022-b929-ab17bf8eba4a" width="500" />



<br/>

2. Utility 창에서 Custom Class 설정


<img src="https://github.com/silverpoodle/iOS_swift/assets/bdcf51c5-a717-43d5-bce9-9192122d31c5" width="500" />

<br/>

3. Utility 창에서 Input Type 설정

   <img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/0b267f7e-53a9-40e7-9baa-2396ee2d1c78" width="300" />

<br/>

4. **Border Style: doted line(첫번째)**: 폰트에 맞게 높이 변경

<img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/12ff1b5e-569b-4238-86cc-5f0617b95cc3" width="300" />



<br/>

5. **IBOutlet**: 스토리보드의 UIView객체를 자동으로 ViewController의 변수와 연결

   **IBAction**: 스토리보드의 UIView객체의 이벤트 핸들러 함수를 자동으로 ViewController의 함수와 연결

   > 연결 시 Document Outline에서 위치가 바뀌어도 문제 X
   >
   > 1. option + 클릭 (여러 document 동시 open)
   > 2. ctrl + 드래그 -> outlet 자동 생성 (변수 선언 x)
   > 3. 변수 선언 후 동그라미 드래그 -> 객체 연결

<br/>

7. Action 연결 -> Editing Changed

   <img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/b4d939e4-af06-44c2-a14b-a7b9d897f16a" width="250"/>

   - UITextField나 UITextView와 같은 텍스트 입력 필드에서 텍스트가 변경될 때마다 실행되는 이벤트
   - 이를 활용하여 사용자가 텍스트를 입력하거나 수정할 때마다 실시간으로 입력된 내용에 반응하는 작업을 수행

   <br/>

8. **Delegate**

<img src="https://www.andrewcbancroft.com/wp-content/uploads/2015/02/Delegate_Environment.png" alt="How Delegation Works – A Swift Developer's Guide" style="zoom:67%;" />

<br/>

**`위임(Delegation)`**

- 위임은 한 객체가 자신이 할 일 중 일부를 다른 객체에게 위임하는 것을 의미
- 이때 일을 위임하는 객체를 "델리게이트(Delegate)", 위임받은 객체를 "델리게이트 객체(Delegate Object)"



**`Delegate`**

- 델리게이트는 특정 객체가 해야 하는 일을 대신 처리하는 객체
- 주로 인터페이스를 정의하고, 해당 인터페이스를 구현한 객체를 델리게이트로 지정하여 특정 동작을 위임



**`Callback 함수`**

- 콜백 함수는 어떤 이벤트가 발생했을 때 호출되는 함수
- 델리게이트는 자신이 처리해야 할 일을 다른 객체에게 위임하고, 해당 일이 완료되면 델리게이트에게 알려줄 필요가 있습니다. 이를 위해 콜백 함수를 사용
- 따라서 델리게이트에는 여러 개의 콜백 함수가 내포



**`Protocol`**

- 인터페이스를 정의하는 데 사용되는 중요한 요소,  특정 작업 또는 동작의 요구사항을 선언하는데 사용
-  프로토콜은 특정 작업이나 동작의 요구사항을 정의 ,구현은 제공하지 않음

<br/>

9. 코드 정리

```swift
//
//  HierarchyViewController.swift
//  ViewHierarchy
//
//  Created by Son Jungin on 2024/04/16.
//

import UIKit

class HierarchyViewController: UIViewController {
    
    // 화씨 입력 필드와 섭씨 표시 라벨에 대한 아웃렛
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var celciusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰에 탭 제스처를 추가하여 키보드가 나타난 상태에서 빈 공간을 터치할 때 키보드를 숨김
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // 화씨 입력 필드의 delegate self로 설정
        // delegate는 객체의 특정 기능을 다른 객체에게 위임하는 데 사용
        // 여기서는 UITextFieldDelegate 프로토콜을 따르는 메소드를 이용하여 텍스트 필드의 동작을 관리
        fahrenheitTextField.delegate = self
    }
    
    // 화씨 입력 필드의 편집이 변경될 때 호출되는 액션 메소드
    @IBAction func fahrenheitEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            if let fahrenheitValue = Double(text) {
                // 입력된 화씨 값을 섭씨로 변환하여 라벨에 표시
                let celciusValue = 5.0/9.0*(fahrenheitValue - 32.0)
                celciusLabel.text = String(format: "%.2f", celciusValue)
            } else {
                celciusLabel.text = "???"
            }
        }
    }
}

extension HierarchyViewController {
    // 탭 제스처에 의해 호출되어 키보드를 숨기는 메소드
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        // 현재 화면에서 화씨 입력 필드의 포커스를 해제하여 키보드를 숨김
        fahrenheitTextField.resignFirstResponder()
    }
}

extension HierarchyViewController: UITextFieldDelegate {
    // 소수점이 이미 존재하는지 확인하고 새로운 소수점 입력을 막는 메소드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existing = textField.text?.range(of: ".")
        let coming = string.range(of: ".")
        if existing != nil, coming != nil {
            // 이미 소수점이 있고 새로운 입력이 소수점인 경우 입력을 막음
            return false
        }
        // 그 외의 경우에는 입력을 허용
        return true
    }
}
```

<br/>

8. 실행화면


 <img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/7470018c-cb1d-4f3a-90f3-5f8d952d0aaa" width="250"/>   
 <img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/729e6f4a-665e-4caa-afea-f31358028660" width="250"/>   
 <img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/33df533d-70fb-418e-94bf-bf8673f671a8" width="250"/>   

