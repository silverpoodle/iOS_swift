# 📱 AutoResizing

화면의 크기에 따라 View의 크기를 자동 조절

- 여백 고정기능
- View 크기 조절 기능

<img width="600" alt="스크린샷 2024-04-18 오후 12 17 35" src="https://github.com/silverpoodle/iOS_swift/assets/88484476/d4c88dc2-de30-4510-b424-2596b94f1343">


<br/>

- 설정방법

  - 각 View 객체별로 설정 

  - 원하는 View 객체를 선택한 후 크기 속성 inspector 에서 설정
 
    <img width="600" alt="스크린샷 2024-04-18 오후 12 17 35" src="https://github.com/silverpoodle/iOS_swift/assets/88484476/6ba73b20-5ae3-4fa4-b625-5065d4817d44">

    - View의 너비: 화면의 크기에 따라 비례하여 너비가 조절
    - View의 높이: 화면의 크기가 변하여도 높이는 고정 
    - 왼쪽, 위쪽 여백: 화면의 크기가 변하여도 높이는 고정 
    - 오른쪽, 아래쪽 여백: View의 너비, View의 높이, 왼쪽, 위쪽 여백이후 남는 값
    - View의 너비 고정이 오른쪽 여백 고정보다 우선순



<br>

<br>

# 📱AutoLayout

하나의 View가 어떠한 화면의 크기에 대해서도 좌측상단좌표(left, height) 와 크기(width, height)를 계산할 수 있으면 **Satisfiable layout**
화면상의 **모든 View**가 Satisfiable layout이면 오토레이아웃을 만족

<br/>

### 이웃

<img width="200" src="https://github.com/silverpoodle/iOS_swift/assets/88484476/af96c8b6-7924-4158-910f-97a8391c53ef">


<br/>

- View의 크기(너비, 높이)와 이웃 View와 간격으로 Satisfiable Layout를 이루는 것
- 다른 이웃: 가장 가까운 이웃(Default)
- 가까운 이웃이 없는 경우는 부모

<br/>

### 속성

<br/>

<img width="600" src="https://github.com/silverpoodle/iOS_swift/assets/88484476/ee404e29-0a88-440d-bbb7-d2ef20b48976">


<br/>
<br/>


### Safe Area

<img src="https://miro.medium.com/v2/resize:fit:1400/1*PZST_giuCIKpXZkJh9u52Q.png" width="450" />

- iOS 7에서 애플은 스크린 영역을 가리지 않도록 topLayoutGuide, bottomLayoutGuide 지정
- iOS 11에서 이 속성들을 금지 시쳤고 safe area 를 도입
- Apple은 safe area 밖에 View를 배치하지 말 것 을 권고

<br/>

### 여백 계산

<img src="https://github.com/silverpoodle/iOS_swift/assets/88484476/b6f14013-f296-4070-89f0-e7e5a4e4a07a" width="600" />


<br/><br/>

## ✏️ Review

1. 





> 💡**참고**
> 
>
> https://blog.naver.com/book1693/221430415925
> 
> https://zeddios.tistory.com/1202