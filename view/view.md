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

## ✏️Review



