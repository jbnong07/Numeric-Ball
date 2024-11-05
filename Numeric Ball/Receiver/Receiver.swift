//
//  Receiver.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

class Receiver {
    func receiveMenuSelect() -> Menu {
        let input: String? = readLine()
        
        if let validInput = input {
            switch validInput {
            case "1":
                return .gameStart
            case "2":
                return .gameHistory
            case "q", "Q":
                return .gameExit
            default:
                return .invalidMenu
            }
        } else {
            //입력창이 강제로 종료된 경우로 사용될 일이 매우 희박한 케이스.
            return .invalidMenu
        }
    }
    
    func receiveAnswer() -> NumToIndex{
        let input = readLine()?.map{
            Int(String($0))!
        }
        var answer: NumToIndex = [:]
        for i in 1...input!.count {
            answer[input![i-1]] = i
        }
        return answer
    }
}
