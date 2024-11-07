# 숫자 맞추기 게임

### **힌트를 얻어 최대한 적은 횟수로 상대방(컴퓨터)의 숫자를 맞추는 게임입니다.**

---

## 과제 개요
> **스파르타 2주차 문법 과제**

---

### ✅ Lv1 `~ 11/04`
- [x] 1에서 9까지 서로 다른 임의의 숫자 3개를 정하고 맞추는 게임입니다.
- [x] 정답은 랜덤으로 생성됩니다. (1에서 9까지의 서로 다른 3자리 숫자)

---

### ✅ Lv2 `11/05 - 11/06`
- [x] 정답을 맞추기 위해 3자리 숫자를 입력하고 힌트를 받습니다.
- [x] **힌트**는 야구 용어인 **볼**과 **스트라이크**입니다.
  - 같은 자리에 같은 숫자가 있는 경우 **스트라이크**  
  - 다른 자리에 같은 숫자가 있는 경우 **볼**
- [x] 올바르지 않은 입력값에 대해 오류 메시지를 표시합니다.
- [x] 3자리 숫자가 정답과 같으면 게임이 종료됩니다.

---

### ✅ Lv3 `11/06`
- [x] 정답 숫자를 **0에서 9까지의 서로 다른 3자리 숫자**로 설정합니다.
- [x] 맨 앞자리에 **0**이 오는 것은 불가능합니다.

---

### ✅ Lv4 `11/07`
- [x] 프로그램 시작 시 안내 문구를 표시합니다.
- [x] **게임 시작하기** 선택 시 "필수 구현 기능"의 예시처럼 게임이 진행됩니다.
- [x] 정답을 맞춰 게임이 종료되면 안내 문구를 다시 보여줍니다.

---

### ✅ Lv5 `11/07`
- [x] **게임 기록 보기** 선택 시 완료된 게임들의 시도 횟수를 표시합니다.

---

### ✅ Lv6 `11/07`
- [x] **종료하기** 선택 시 프로그램이 종료됩니다.
- [x] 이전의 게임 기록은 모두 초기화됩니다.
- [x] 1, 2, 3 이외의 입력값에 대해 오류 메시지를 표시합니다.

---

### 🎯 Lv7 `추가 도전 / 목표`
- [x] **게임 기록에서 시도 횟수 순으로 랭킹을 표시합니다.**
- [x] 현재 게임 상태를 관리하는 **싱글톤 객체**를 만들어 활용합니다.
  - **싱글톤 패턴**을 적용했으나, 하나의 클래스에서만 관리하는 상황이므로 **의존성 주입**이 더 바람직하다고 판단.
- [x] 피드백 받은 부분 반영:
  - 불필요한 코드(데드코드) 삭제
  - 에러처리 개선
  - 유지보수와 복잡도를 고려하여 적절한 디자인 패턴과 추상화 수준 유지
- [x] 새로운 디자인 패턴이나 코딩 방식을 적용해 보고, 구현 차이를 느껴보는 것도 목표입니다. (필요 시 선택적으로 구현)
- [x] **상태 관리**와 **분기 방식** 개선:
  1. [x] 상태 관리 열거형에 연관 값을 추가하여 세분화하고 관리
     - 연관값 사용으로 인해 비교 연산자나 해시값이 필요한 딕셔너리의 키로 사용하기 어려운 경우, 문제 해결 필요
  2. [x] 스위치문 대신 **클로저 딕셔너리**를 활용해 상태별 메서드 분기
     - 다수의 스위치 케이스가 있는 경우 딕셔너리 활용이 유리하나, 순환 참조 방지를 위한 **lazy**나 **weak self** 설정에 주의 필요
     - `guard` 문으로 메모리에서 인스턴스 할당 해제 여부를 체크하거나, 옵셔널 체이닝(self?)으로 확인이 필요
     -  가독성이 떨어질 수 있으므로, 현재 프로젝트에서는 명확히 스위치문이 더 나은 선택으로 판단하였으나, 사용 경험을 위해 클로저 딕셔너리를 적용

---

### 🚀 Lv8 `추가 도전`
- [ ] **새로운 기능** 추가 시 각 기능의 추가 난이도를 분석하고, 적용한 디자인 패턴이 어떤 영향을 주었는지 생각 정리해보기
  - [x] **치트 모드**: 메뉴에서 활성화 시 정답을 입력할 때 표시  
  - [ ] **힌트 기능**: 힌트를 받으면 시도 횟수 +10(또는 랭킹 등록 불가) 후, 정답의 숫자 4개를 랜덤 순서로 공개
  - [ ] **메뉴 추가**: 힌트와 치트에 대한 설명 및 게임 진행 방식 설명 제공


### 추가도전을 진행하면서 한 생각
  - **치트모드**
리시버의 역할을 확실히 분리한 것을 유지하기 위한 고민이 필요했음.
이정도는 여기서 처리할까? 라는 생각이 클래스가 가진 책임을 계속 늘리게 만든다고 생각함
직접적인 참조 없이 의존성이 낮게 유지되면서 서로 다른 클래스에서 영향을 주고 받는 방법이 얼마나 다양하고 공부가 필요한지 알게 됨
이번 기회에 여러 코드를 시도해보는 것이 재미있었지만 바탕이 되는 이론을 더 공부했다면 얼마나 더 좋았을까라는 생각을 함.
