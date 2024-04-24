## Programming View



### UIView 이용

```swift
import UIKit

class ConversionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Outer UIView 설정
        let outer = UIView()
        outer.backgroundColor = UIColor(red: 00, green: 0xff, blue: 0xff, alpha: 1) // 노란색으로 설정
        outer.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용을 위한 설정
        
        // Outer UIView를 뷰 계층에 추가
        view.addSubview(outer)
        
        // Outer UIView의 제약 조건 설정
        NSLayoutConstraint.activate([
            outer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), // Safe Area의 leading에 맞추고 왼쪽 여백 20
            outer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), // Safe Area의 trailing에 맞추고 오른쪽 여백 20
            outer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100), // Safe Area의 top에 맞추고 위쪽 여백 100
            outer.heightAnchor.constraint(equalToConstant: 120), // 높이를 120으로 고정
        ])
        
        // UILabel 생성 및 초기화
        let nameLabel = UILabel()
        nameLabel.text = "Name" // 텍스트 설정
        nameLabel.backgroundColor = .green // 초록색으로 설정
        nameLabel.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용을 위한 설정
        
        // UITextField 생성 및 초기화
        let nameTextField = UITextField()
        nameTextField.backgroundColor = .yellow // 노란색으로 설정
        nameTextField.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용을 위한 설정
        
        // Outer UIView에 UILabel과 UITextField를 추가
        outer.addSubview(nameLabel)
        outer.addSubview(nameTextField)
        
        // UILabel과 UITextField의 Content Hugging Priority 설정
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal) // UILabel이 수평 방향으로 높은 우선순위를 가짐
        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal) // UITextField가 수평 방향으로 낮은 우선순위를 가짐
        
        // UILabel과 UITextField의 제약 조건 설정
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: outer.centerYAnchor), // UILabel의 센터 Y축을 Outer UIView의 센터 Y축에 맞춤
            nameLabel.leadingAnchor.constraint(equalTo: outer.leadingAnchor, constant: 0), // UILabel의 leading을 Outer UIView의 leading에 맞춤
            nameLabel.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -10), // UILabel의 trailing을 UITextField의 leading에 맞추고 오른쪽 여백 10
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0), // UITextField의 센터 Y축을 UILabel의 센터 Y축에 맞춤
            nameTextField.trailingAnchor.constraint(equalTo: outer.trailingAnchor, constant: 0), // UITextField의 trailing을 Outer UIView의 trailing에 맞춤
        ])
    }
}

```

<br/>

> 💡**qualTo vs equalToConstant**
>
> 1. `equalTo`: 이 메서드는 다른 뷰의 속성이나 앵커(anchor)에 현재 뷰의 속성이나 앵커를 맞추는 데 사용
>    예를 들어, `constraint(equalTo:)`를 사용하여 뷰의 leading, trailing, top, bottom, centerX, centerY 등을
>    다른 뷰의 앵커에 맞출 수 있습니다. (두 개의 앵커 또는 뷰의 속성을 연결하는 제약 조건을 생성)
> 2. `equalToConstant`: 이 메서드는 제약 조건의 값을 특정 상수로 설정하는 데 사용. 
>    보통 너비, 높이 등의 고정된 값을 설정할 때 유용합니다. 
>    예를 들어, `widthAnchor.constraint(equalToConstant:)`를 사용하여 뷰의 너비를 고정된 값으로 설정할 수 있습니다.

<br/>

<br/>

### UIStackView 이용

```swift
import UIKit

class ConversionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIStackView 생성
        let outer = UIStackView()
        outer.backgroundColor = UIColor(red: 00, green: 0xff, blue: 0xff, alpha: 1) // 노란색으로 설정
        outer.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용을 위한 설정
        
        // UIStackView 속성 설정
        outer.axis = .horizontal // 수평으로 정렬
        outer.alignment = .center // 요소들을 가운데 정렬
        outer.distribution = .fill // 요소들을 균등하게 배치
        outer.spacing = 10 // 요소들 사이의 간격 설정
        
        // 뷰에 UIStackView 추가
        view.addSubview(outer)
        
        // UIStackView의 제약 조건 설정
        NSLayoutConstraint.activate([
            outer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), // Safe Area의 leading에 맞추고 왼쪽 여백 20
            outer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), // Safe Area의 trailing에 맞추고 오른쪽 여백 20
            outer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100), // Safe Area의 top에 맞추고 위쪽 여백 100
            outer.heightAnchor.constraint(equalToConstant: 120), // 높이를 120으로 고정
        ])
        
        // UILabel 생성 및 초기화
        let nameLabel = UILabel()
        nameLabel.text = "Name" // 텍스트 설정
        nameLabel.backgroundColor = .green // 초록색으로 설정
        nameLabel.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용을 위한 설정
        
        // UITextField 생성 및 초기화
        let nameTextField = UITextField()
        nameTextField.backgroundColor = .yellow // 노란색으로 설정
        nameTextField.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용을 위한 설정
        
        // UIStackView에 UILabel과 UITextField 추가
        outer.addArrangedSubview(nameLabel)
        outer.addArrangedSubview(nameTextField)
        
        // UILabel과 UITextField의 Content Hugging Priority 설정
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal) // UILabel이 수평 방향으로 높은 우선순위를 가짐
        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal) // UITextField가 수평 방향으로 낮은 우선순위를 가짐

    }
}
```

<br/>

> 💡 **addArrangedSubView**
>
> 자식뷰를 추 가하면서 StackView의 규칙을 따른다
> ex) axis, alignment, distribution등

<br/>

<br/>

### Action

```swift
import UIKit

class ConversionViewController: UIViewController {
    
    // Interface Builder와 연결된 이미지 뷰
    @IBOutlet weak var birdImageView: UIImageView!
    
    // Interface Builder와 연결된 새의 좌측 제약 조건
    @IBOutlet weak var birdLeadingConstraint: NSLayoutConstraint!
    
    // Interface Builder와 연결된 새의 상단 제약 조건
    @IBOutlet weak var birdTopContraint: NSLayoutConstraint!
    
    // 타이머 변수
    var timer: Timer!
    
    // 새의 이동 방향을 나타내는 변수
    var direction = 1
    
    // 타이머에 의해 주기적으로 호출되는 메서드
    @objc func timerAction() {
        // 새의 좌표를 변경하여 이동시킴
        birdLeadingConstraint.constant += CGFloat(direction * 10)
        
        // 새가 화면 오른쪽 끝에 닿으면 방향을 반대로 변경하고 이미지를 좌우 반전시킴
        if birdLeadingConstraint.constant + birdImageView.frame.size.width >= view.frame.size.width {
            direction = -1
            // 이미지를 좌우로 반전시키는 변환을 적용
            birdImageView.transform = .init(scaleX: -1, y: 1) 
        }
        // 새가 화면 왼쪽 끝에 닿으면 방향을 반대로 변경하고 이미지를 원래대로 돌림
        else if birdLeadingConstraint.constant < 0 {
            direction = 1
            // 이미지를 원래대로 돌리는 변환을 적용
            birdImageView.transform = .init(scaleX: 1, y: 1)
        }
    }

    // 버튼 클릭 이벤트를 처리하는 메서드
    @objc func buttonPressed(_ sender: UIButton){
        // 버튼의 텍스트를 확인하여 타이머를 시작하거나 중지함
        if let text = sender.titleLabel?.text {
            if text == "start" {
                // 타이머를 시작하고 타이머 동작 메서드를 반복 호출
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                             selector: #selector(timerAction),
                                             userInfo: nil, repeats: true)
            } else {
                // 타이머를 중지함
                timer.invalidate()
            }
            // 버튼의 텍스트를 시작 또는 중지로 변경함
            sender.setTitle((text == "Start") ? "Stop" : "Start", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼 생성 및 설정
        let button = UIButton()
        button.setTitle("start", for: .normal) // 버튼 텍스트 설정
        button.backgroundColor = .green // 배경색 설정
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용을 위한 설정
        
        // 뷰에 버튼 추가
        view.addSubview(button)
        
        // 버튼의 제약 조건 설정
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), // 가로 중앙 정렬
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), // 아래에 붙임
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5) // 너비를 뷰의 절반으로 설정
        ]);
        
        // 버튼에 타겟 메서드 연결
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
}
```

