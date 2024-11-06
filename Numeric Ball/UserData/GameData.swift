//
//  Model.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//
/*
 필요한 프로퍼티
    정답
    사용자의 입력
    해당 게임 회차
    회차별 정답까지의 시행횟수
 
 싱글톤을 적용해야 할까?
    정답과 사용자의 입력은 매 게임마다 새롭게 설정되기 때문에 싱글톤을 적용할 필요가 없다고 생각됨
    야구 게임이 시행되는 것과 별개로 한 번의 게임 세션동안 회차별 기록은 유지되어야 하므로 싱글톤을 적용하는 것도 나쁘지 않다고 생각됨
 
 결론
    정답, 사용자의 입력, 해당 회차의 시행횟수를 저장하는 구조체를 만들어 매 게임마다 생성
    클래스를 이용하여 하나의 기록 데이터에 접근. 매 회차별 시행 횟수를 전달하고 기록 메뉴에서 회차별 기록을 표시하기
 
 타입
    정답과 사용자의 입력을 비교하기 위한 알고리즘을 먼저 생각해야 함.
    
 */
import Foundation

struct GameData {
    private var answer: NumToIndex = [:]
    private var userAnswer: NumToIndex = [:]
    private var inputCount: Int = 0
    private var strikeAndBall: StrikeAndBall = (strike: 0, ball: 0)
    
    mutating func setCorrectAnswer(as answer: NumToIndex) {
        self.answer = answer
    }
    
    mutating func setReceiveAnswer(from answer: NumToIndex) {
        self.userAnswer = answer
    }
    
    mutating func setStrikeAndBall(as strikeAndBall: StrikeAndBall) {
        self.strikeAndBall = strikeAndBall
    }
    
    func getStrikeAndBall() -> StrikeAndBall {
        return strikeAndBall
    }
}

