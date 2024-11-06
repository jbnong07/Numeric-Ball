//
//  State.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/5/24.
//

//모든 클래스에서 동일한 상태관리 객체에 접근하기 위해 싱글톤으로 구현
//게임을 진행하는 상위클래스에서만 사용되므로 싱글톤 패턴을 빼고 주입함.
final class GameStatus {
    //외부에서 상태를 쉽게 수정할 수는 없지만 읽기는 가능하게 하기 위해서 private(set) 사용
    private(set) var status: Status = .inGameMenu
    
    func updateStatus(to status: Status) {
        self.status = status
    }
    
}

extension GameStatus {
    enum Status {
        case inGameMenu
        case gamePlaying
        case gameEnd
        case gameStop
        case stopRunning
    }
}
