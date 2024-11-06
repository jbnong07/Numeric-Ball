//
//  AnswerGenerator.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

/*
 정답 생성기
 조건
    1. 0으로 시작할 수 없음
    2. 4자리 숫자를 바탕으로 만드는 딕셔너리
    3. key에 4자리 숫자
    3. 중복된 숫자가 나올 수 없음
    4. 매번 랜덤하게 생성
 
 배열 이용 알고리즘
    배열에다 넣어서 인덱스랑 요소를 매치시켜서 딕셔너리를 만들 것.
    배열의 첫 인덱스에는 랜덤으로 1...9의 수를 넣는다.
    나머지 수는 배열의 카운트가 4가 될 때까지 랜덤으로 0...9를 넣는다.
    단, .contain을 활용하여 랜덤한 숫자가 이미 배열에 있을 경우 다시 랜덤 숫자를 만든다.
 
 세트 이용 알고리즘
    랜덤한 숫자를 Set에 넣는다.
    Set에는 중복이 허용되지 않으므로 count가 4가 될 때까지 반복.
    인덱스가 1이고 값이 0이면 해당 차례를 넘기고 다시 인덱스 1에 값을 넣는 과정을 진행
 
 처음부터 딕셔너리의 키를 랜덤한 수를 생성하여 입력하기.
    랜덤한 수 1...9를 key로 설정하고 value를 1로 설정한다.
    랜덤한 수 0...9를 key로 설정하고 value를 2, 3, 4로 각각 설정한다.
        >>중복 방지를 빼먹었다.
    > 가드렛으로 해당 키가 없는 경우에만 랜덤한 수를 새로운 키로 넣고 밸류를 지정한다.
 */

//여러 알고리즘 테스트를 위해 프로토콜 설정
protocol GeneratorProtocol {
    func generateAnswer() -> NumToIndex
}

final class AnswerGenerator: GeneratorProtocol {
    func generateAnswer() -> NumToIndex{
        var answer: NumToIndex = [:]
        var index: Int = 1
        //첫 번째 수를 1...9사이에서 지정
        answer[Int.random(in: 1...9)] = index
        //인덱스 하나 증가
        index += 1
        
        //남은 숫자 3개를 생성
        while answer.count < 4 {
            let randomNum = Int.random(in: 0...9)
            if answer[randomNum] == nil {
                answer[randomNum] = index
                index += 1
            }
        }
        return answer
    }
}

class ArrayAnswerGenerator: GeneratorProtocol {
    func generateAnswer() -> NumToIndex {
        var answer: NumToIndex = [:]
        //배열을 이용한 알고리즘 
        return answer
    }
}
