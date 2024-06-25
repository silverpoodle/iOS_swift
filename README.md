<div align="center">
  
  # 🪜 Letter Ladder 🪜

  <br>

  <img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/02ef984e-1707-4ab0-be0f-34b4fcb28a28" width="400"/>

  <br>
 
  **💚💛🩶재밌는 게임을 하며 새로운 단어를 공부해보세요💚💛🩶**




<br>
<br>

 **1️⃣ WORDLE 게임 플레이**

 **2️⃣ 플레이 중 ChatGPT 의 도움을 받아 새로운 단어 학습**

<br>
<br>
<br>
</div>

## 🪜 시연 영상
[![Video Label](https://github.com/silverpoodle/iOS_swift/assets/88484476/142dc667-a533-4a3d-8732-8b277eb530a2)](https://youtu.be/_26yNXK7ZzQ)


<br>
<br>

## 🪜 사용 API

| API                     | 사용 상황                                                                                       | 설명                                                                                                  |
|-------------------------|------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| **Free Dictionary API** | 단어의 유효성을 검사하고 단어의 뜻을 가져올 때 사용                                                        | 사용자가 입력한 단어가 실제로 존재하는지 확인하고 그 뜻을 가져오는 데 사용됩니다. 예를 들어, 단어가 유효한지 검사할 때 사용      |
| **OpenAI API**          | 단어의 뜻을 한글로 번역하고 예문을 생성할 때 사용                                                    | 사용자가 입력한 단어를 한글로 번역하고, 예문을 생성하고, 그 예문을 한글로 번역하는 데 사용. GPT-3.5 모델을 이용    |

<br>
<br>


## 🪜 배운 내용 정리


| 기술              | 상황                                                                                       |
|-------------------|------------------------------------------------------------------------------------------|
| **Protocol**  | `ResultViewControllerDelegate`를 정의하고, `ResultViewController`와 `ViewController` 간의 통신에 사용<br>`KeyBoardViewControllerDelegate`를 정의하여 키보드 입력 이벤트를 처리할 때 사용<br>`BoardViewControllerDataSource`를 정의하여 보드의 데이터를 제공할 때 사용 |
| **Extension** | `ViewController`에서 `KeyBoardViewControllerDelegate`, `BoardViewControllerDataSource`, `ResultViewControllerDelegate` 프로토콜을 구현할 때 사용<br>`UIView`의 `shake` 메서드를 정의하여 뷰 애니메이션을 추가할 때 사용 |
| **UIViewController** | `ViewController`, `ResultViewController` 등의 뷰 컨트롤러를 정의하고 관리                                             |
| **UIStackView**   | 버튼과 이미지를 가로로 배치하여 레이아웃을 구성할 때 사용                                                    |
| **NSLayoutConstraint** | Auto Layout을 사용하여 뷰의 위치와 크기를 지정할 때 사용                                                   |
| **UIView**        | 컨테이너 뷰 및 애니메이션 효과를 위한 뷰를 생성할 때 사용                                                  |
| **UICollectionView** | 단어 맞추기 보드와 키보드를 구성하는 데 사용                                                        |
| **CAEmitterLayer** | Confetti 애니메이션을 생성하고 관리할 때 사용                                                          |
| **UIWindow**      | Confetti 애니메이션을 최상위 레벨에서 표시할 때 사용                                                     |
| **NSAttributedString** | 텍스트에 다양한 스타일을 적용할 때 사용                                                             |
| **DispatchQueue** | 비동기 작업을 처리하고 UI 업데이트를 메인 스레드에서 수행할 때 사용                                         |
| **CAKeyframeAnimation** | 셀 애니메이션을 구성하여 셀이 흔들리는 효과를 줄 때 사용                                               |


<br>
<br>

## 🪜 주요 함수 & 클래스

| 클래스              | 설명                                                                                       |
|-------------------|------------------------------------------------------------------------------------------|
| **ViewController**   | 메인 게임 뷰 컨트롤러. 단어 맞추기 게임의 전체 로직을 관리                                             |
| **ResultViewController** | 게임 결과를 표시하는 뷰 컨트롤러                                                     |
| **KeyboardViewController** | 키보드 입력을 처리하는 뷰 컨트롤러                                                  |
| **BoardViewController** | 게임 보드를 표시하고 관리하는 뷰 컨트롤러                                              |
| **KeyCell**        | 키보드의 개별 키를 표시하는 컬렉션 뷰 셀                                                   |
| **BoardCell**      | 게임 보드의 개별 셀을 표시하는 컬렉션 뷰 셀                                                |

<br>
<br>

| 함수              | 설명                                                                                       |
|-------------------|------------------------------------------------------------------------------------------|
| **ViewController** |                                                                                          |
| `viewDidLoad`      | 뷰가 메모리에 로드될 때 호출되며, 초기 설정을 수행                                        |
| `addChildren`      | 자식 뷰 컨트롤러를 추가하고, 레이아웃을 설정                                              |
| `addConstraints`   | 뷰의 레이아웃 제약 조건을 추가                                                           |
| `isGuessComplete`  | 현재 추측이 완성되었는지 확인                                                             |
| `showConfetti`     | confetti 애니메이션을 표시                                                                |
| `generateConfettiCells` | confetti 셀을 생성하여 반환                                                            |
| `randomColor`      | 임의의 색상을 반환                                                                       |
| `showResult`       | 게임 결과를 표시하는 모달을 표시                                                         |
| `resetGameboard`   | 게임 보드를 리셋하고 새 게임을 시작                                                      |
| `keyboardViewControllerDidTapEnter` | 키보드의 엔터 키가 눌렸을 때 호출되며, 단어 유효성을 검사하고 결과를 처리              |
| `shakeCurrentRow`  | 현재 행을 흔드는 애니메이션을 추가                                                        |
| `checkGuess`       | 사용자가 입력한 단어가 정답과 일치하는지 확인하고 보드 색상을 업데이트                    |
| **ResultViewController** |                                                                                          |
| `viewDidLoad`      | 뷰가 메모리에 로드될 때 호출되며, 초기 설정을 수행                                        |
| `addSubviews`      | 여러 서브뷰를 추가                                                                        |
| `configure`        | 뷰 컨트롤러를 구성하고 데이터로 채움                                                      |
| `setUpConstraints` | 뷰의 레이아웃 제약 조건을 설정                                                            |
| `resetGameboard`   | 리셋 버튼이 눌렸을 때 호출되며, 게임 보드를 리셋                                          |
| **KeyboardViewController** |                                                                                          |
| `viewDidLoad`      | 뷰가 메모리에 로드될 때 호출되며, 초기 설정을 수행                                        |
| `reloadData`       | 키보드의 데이터를 리로드                                                                  |
| `updateKeyColor`   | 특정 키의 색상을 업데이트                                                                 |
| `collectionView(_:numberOfItemsInSection:)` | 컬렉션 뷰 섹션의 항목 수를 반환                                     |
| `collectionView(_:cellForItemAt:)` | 컬렉션 뷰의 셀을 구성하고 반환                                              |
| `collectionView(_:didSelectItemAt:)` | 키보드의 키가 눌렸을 때 호출                                               |
| **BoardViewController** |                                                                                          |
| `viewDidLoad`      | 뷰가 메모리에 로드될 때 호출되며, 초기 설정을 수행                                        |
| `reloadData`       | 보드의 데이터를 리로드                                                                    |
| `updateBoxColor(at:color:)` | 특정 셀의 색상을 업데이트                                                         |
| `collectionView(_:numberOfItemsInSection:)` | 컬렉션 뷰 섹션의 항목 수를 반환                                     |
| `collectionView(_:cellForItemAt:)` | 컬렉션 뷰의 셀을 구성하고 반환                                              |
| `collectionView(_:didSelectItemAt:)` | 보드의 셀이 눌렸을 때 호출                                                |
| **KeyCell**        |                                                                                          |
| `init(frame:)`     | 셀이 초기화될 때 호출되며, 초기 설정을 수행                                               |
| `prepareForReuse`  | 셀이 재사용될 때 호출되며, 초기 상태로 재설정                                             |
| `configure(with:isDelete:isEnter:color:)` | 셀을 구성하고 데이터를 채움                                          |
| **BoardCell**      |                                                                                          |
| `init(frame:)`     | 셀이 초기화될 때 호출되며, 초기 설정을 수행                                               |
| `prepareForReuse`  | 셀이 재사용될 때 호출되며, 초기 상태로 재설정                                             |
| `configure(with:color:isSelected:)` | 셀을 구성하고 데이터를 채움                                              |
| `animateSelection(to:)` | 선택 애니메이션을 실행                                                              |

