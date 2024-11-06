//
//  Receiver.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

class Receiver {
    //지정된 입력이 없을 경우 에러 발생
    func receiveMenuSelect() throws -> GameStatus.Status {
        let input: String? = readLine()
        
        if let validInput = input {
            switch validInput {
            case "1":
                return .play(.gamePlay)
            case "2":
                return .menu(.gameHistory)
            case "3", "q", "Q":
                return .menu(.gameOff)
            default:
                throw ErrorCase.inputInvalidMenu //알맞은 입력이 아닌 경우 에러처리
            }
        } else {
            //입력창이 강제로 종료된 경우로 사용될 일이 매우 희박한 케이스.
            throw ErrorCase.inputNil
        }
    }
    
    func receiveAnswer() throws -> NumToIndex?{
        var answer: NumToIndex = [:]
        
        guard let input = readLine() else { throw ErrorCase.inputNil }//입력창이 닫혀 ""도 입력되지 못한 경우
        if input == "q" { return nil }//q를 입력받아 게임 중단이 가능하게 하기 위함
        guard input.first != "0" else { throw ErrorCase.inputZeroToFirstIndex }//0으로 시작하는 경우
        guard input.allSatisfy({ $0.isNumber }) else { throw ErrorCase.inputString }  //기존 Int()검사로는 -입력을 캐치하지 못했음
        guard input.count == 4 else { throw ErrorCase.inputNotFourLength }//4자리의 문자열이 아닌 경우
        guard Set(input).count == 4 else { throw ErrorCase.inputDuplicateNumber }//중복된 문자가 있는 경우
        
        for (index, number) in input.enumerated() {
            if let validNum = Int(String(number)) {
                answer[validNum] = index + 1
            }
        }
        
        return answer
    }
    
    func receiveContinue() {
        _ = readLine()
    }
}
