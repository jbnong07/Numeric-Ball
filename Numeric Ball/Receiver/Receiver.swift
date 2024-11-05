//
//  Receiver.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

class Receiver {
    func receiveMenuSelect() -> String {
        let input: String? = readLine()
        
        if let validInput = input {
            switch validInput {
            case "1":
                return "gameStart"
            case "2":
                return "gameHistory"
            case "q", "Q":
                return "gameExit"
            default:
                return ""//에러처리
            }
        } else {
            //빈 칸입력에 대한 오류 발생 후 다시 입력받기
        }
    }
    
}
