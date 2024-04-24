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

1. Align Tool 활용

   -  Align Tool은 뷰들을 정렬 시키는데 사용

   - 원하는 뷰들을 선택하고 Align Tool을 클릭

   - 팝업에서 적절한 제약조건을 선택후 추가

   - **오토레이아웃은 View가 Satisfiable Layout가 아니면 적용되지 않음**

     <br/>

   <img src="../../../Library/Application Support/typora-user-images/스크린샷 2024-04-23 오후 9.47.49.png" alt="스크린샷 2024-04-23 오후 9.47.49" style="zoom:40%;" />

<br/>

2. (1) 의 AutoLayout 적용 결과

![스크린샷 2024-04-23 오후 9.49.13](../../../Library/Application Support/typora-user-images/스크린샷 2024-04-23 오후 9.49.13.png)

- constraint가 적용될때마다 Document Outline에 객체가 하나씩 생성 -> 현재 2개가 적용
- Document Outline에서 선택된 constraint에 대하여 상세 내역 확인
- constraint도 outlet 변수로 적용 가능

<br/>

3. Pin Tool 활용
   - 뷰의 상대적 위치와 크기에 대한 제약조건을 적용
   - 원하는 뷰를 선택하고 Pin Tool을 클릭

![스크린샷 2024-04-23 오후 9.59.20](../../../Library/Application Support/typora-user-images/스크린샷 2024-04-23 오후 9.59.20.png)



<br/>

4. **허깅 우선순위(hugging priority)**

   - 크기에 대한 설정이 없는 뷰 객체는 가장 낮은 우선순위

     

<img src="../../../Library/Application Support/typora-user-images/스크린샷 2024-04-23 오후 10.03.15.png" alt="스크린샷 2024-04-23 오후 10.03.15" style="zoom:30%;" />

<br/>

5. **압축저항 우선순위(compression resistance priority)**
   - 크기에 대한 설정이 없는 뷰 객체는 가장 낮은 우선순위

<img src="../../../Library/Application Support/typora-user-images/스크린샷 2024-04-23 오후 10.05.15.png" alt="스크린샷 2024-04-23 오후 10.05.15" style="zoom:30%;" />

<br/>



> 💡**참고**
> 
>
> https://blog.naver.com/book1693/221430415925
> 
> https://zeddios.tistory.com/1202
