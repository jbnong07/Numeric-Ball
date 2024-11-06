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
    private(set) var status: Status = .menu(.inGameMenu)
    
    func updateStatus(to status: Status) {
        self.status = status
    }
    
}

//게임 메뉴와 관련된 상태와 플레이에 관련된 상태를 연관값으로 쉽게 구분해보려는 시도
//비교 연산자 사용이 불가능해지게 되었음 -> while case 등 case를 이용한 패턴 매칭을 알게 되었음.
//메뉴 구분은 조금 더 쉬워졌으나 while문의 조건에서 바로 특정 상태가 되기 전까지 반복하는 로직이 불가능해져 추가적인 break문이 필요하게 됨
//Equatable을 준수하거나 연산프로퍼티를 사용하면 비교가 가능해짐
//아직은 연관값으로 메뉴와 게임 플레이를 구분하는 것보다 훨씬 코드가 복잡해지기만 한다는 느낌을 받음
extension GameStatus {
    enum Status: Equatable {
        case menu(Menu)
        case play(Play)
        
        enum Menu {
            case inGameMenu
            case gameHistory
            case gameOff
        }
        
        enum Play {
            case gamePlay
            case gameEnd
            case gameStop
        }
        
        static func == (lhs: Status, rhs: Status) -> Bool {
            switch (lhs, rhs) {
            case (.menu(.gameOff), .menu(.gameOff)):
                return true
            case (.menu(.inGameMenu), .menu(.inGameMenu)):
                return true
            case (.menu(.gameHistory), .menu(.gameHistory)):
                return true
            case (.play(.gamePlay), .play(.gamePlay)):
                return true
            case (.play(.gameEnd), .play(.gameEnd)):
                return true
            case (.play(.gameStop), .play(.gameStop)):
                return true
            default:
                return false
            }
        }
    }
}

