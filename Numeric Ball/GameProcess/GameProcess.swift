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
    private var gameData: AnswerData = AnswerData()
    
    //비교할 정답을 초기화 시점에서 받아온다
    init(correctAnswer: NumToIndex){
        self.gameData.correctAnswer = correctAnswer
    }
    
    
    func gameProcess(answer: NumToIndex, receive: NumToIndex, inputCount: inout Int) -> StrikeAndBall {
        var strike: Int = 0
        var ball: Int = 0
        
        //딕셔너리에 해당하는 키가 없을 경우 옵셔널이 반환되는 점을 활용하여 반복문 2번을 사용하는 것보다 시간복잡도를 낮출 수 있었음.
        for num in receive.keys {
            if let matchedValue = answer[num] {
                if matchedValue == receive[num] {
                    self.gameData.strikeAndBall = (strike: strike + 1, ball: ball)
                } else {
                    self.gameData.strikeAndBall = (strike: strike, ball: ball + 1)
                }
            }
        }
        return (gameData.strikeAndBall)
    }
}

extension GameProcess {
    struct AnswerData {
        var correctAnswer: NumToIndex = [:]
        var strikeAndBall: StrikeAndBall = (strike:0, ball: 0)
    }
}
