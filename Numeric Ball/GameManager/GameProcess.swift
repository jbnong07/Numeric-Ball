//
//  HintCalculator.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/5/24.
//

//몇 스트라이크와 몇 볼인지에 대해 계산하고 반환하는 클래스
//추가적인 기능확장이나 테스트가 필요없다고 판단하여 추상화나 상속을 하지 않도록 설정함
//이름이 설정된 튜플을 반환함으로써 사용자가 정확하게 strike와 ball을 구분하여 사용할 수 있게 유도함

final class GameProcess {
    struct AnswerData {//중첩 타입을 정의하고 GameProcess에 종속되었다는 걸 한 눈에 알기 쉽게 extension에서 첫 줄로 옮김
        var correctAnswer: NumToIndex = [:]
        var strikeAndBall: StrikeAndBall = (strike:0, ball: 0)
    }
    
    private(set) var gameData: AnswerData = AnswerData()
    
    //정답 생성기로 생성된 값을 전달받는 메서드
    func setCorrectAnswer(as answer: NumToIndex) {
        self.gameData.correctAnswer = answer
    }
    
    //스트라이크와 볼의 수를 계산 후 반환
    func gameProcess(receive: NumToIndex) -> StrikeAndBall {
        //딕셔너리에 해당하는 키가 없을 경우 nil이 반환되는 점을 활용하여 반복문 2번을 사용하는 것보다 시간복잡도를 낮출 수 있었음.
        self.gameData.strikeAndBall = (strike: 0, ball: 0)
        for num in receive.keys {
            if let matchedValue = gameData.correctAnswer[num] {
                if matchedValue == receive[num] {
                    self.gameData.strikeAndBall.strike += 1
                } else {
                    self.gameData.strikeAndBall.ball += 1
                }
            }
        }
        return (gameData.strikeAndBall)
    }
}

extension GameProcess {
    
}
