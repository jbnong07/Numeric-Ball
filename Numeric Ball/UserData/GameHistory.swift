//
//  GameHistory.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//


struct GameHistory {
    //캡슐화를 위한 접근수준 설정
    //회차 기록은 배열의 인덱스로 대체할 수 있으므로 시행횟수만 담는 배열로 타입 지정
    private var history: Ranking = [:]

    mutating func addGameHistory(reps: Int, round: Int) {
        //게임이 종료된 직후 호출된 경우에만 기록을 추가하게 됨.
        if GameStatus.shared.gameStatus == .gameEnd {
            history[reps] = round
        }
        
    }
    
    func getHistory() -> Ranking {
        return history
    }
}
