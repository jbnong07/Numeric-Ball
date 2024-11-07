//
//  Receiver.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

final class Receiver {
    //지정된 입력이 없을 경우 에러 발생
    func receiveMenuSelect() throws -> GameStatus.Status {
        let input: String? = readLine()
        
        if let validInput = input {
            switch validInput {
            case "1":
                return .play(.gameStart)
            case "2":
                return .menu(.gameHistory)
            case "3", "q", "Q":
                return .menu(.gameOff)
            case "cheat":
                return .menu(.cheatMode)
            default:
                throw ErrorCase.inputInvalidMenu //알맞은 입력이 아닌 경우 에러처리
            }
        } else {
            //입력창이 강제로 종료된 경우로 사용될 일이 매우 희박한 케이스.
            throw ErrorCase.inputNil
        }
    }
    
    func receiveAnswer() throws -> String{
        guard let input = readLine() else { throw ErrorCase.inputNil }//입력창이 닫혀 ""도 입력되지 못한 경우
        return input
    }
    
    func receiveContinue() {
        _ = readLine()
    }
}
