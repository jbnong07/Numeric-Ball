//
//  Receiver.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

class Receiver {
    //지정된 입력이 없을 경우 에러 발생
    func receiveMenuSelect() throws -> Menu {
        let input: String? = readLine()
        
        if let validInput = input {
            switch validInput {
            case "1":
                return .gameStart
            case "2":
                return .gameHistory
            case "3", "q", "Q":
                return .gameExit
            default:
                throw ErrorCase.inputInvalidMenu //알맞은 입력이 아닌 경우
            }
        } else {
            //입력창이 강제로 종료된 경우로 사용될 일이 매우 희박한 케이스.
            throw ErrorCase.inputNil
        }
    }
    
    func receiveAnswer() -> NumToIndex?{
//예외처리를 위한 코드 개선 필수
        let input = readLine()?.map{
            Int(String($0))!
        }

        var answer: NumToIndex = [:]
        for i in 1...input!.count {
            answer[input![i-1]] = i
        }
        return answer
    }
    
    func receiveContinue() {
        _ = readLine()
    }
}
