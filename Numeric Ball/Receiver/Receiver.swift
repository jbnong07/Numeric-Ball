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
                throw ErrorCase.inputInvalidMenu //알맞은 입력이 아닌 경우 에러처리
            }
        } else {
            //입력창이 강제로 종료된 경우로 사용될 일이 매우 희박한 케이스.
            throw ErrorCase.inputNil
        }
    }
    
    func receiveAnswer() throws -> NumToIndex?{
        var answer: NumToIndex = [:]
        
        guard let input = readLine() else { throw ErrorCase.inputNil }
        
        
        
        if let input = readLine() {//nil인지 검사
            if input == "q" {
                return nil
            }
            else if Int(input) != nil {//정수를 입력했는지 검사
                if input.count == 4{//4자리인지 검사
                    if input.first != "0"{//0이 맨 앞에 있는 경우 검사
                        if Set(input).count == 4{//Set에 문자열을 넣음으로써 중복된 값을 제거했을 때 여전히 4개의 문자가 남아있는지 검사
                            for (index, number) in input.enumerated() {
                                answer[Int(String(number))!] = index + 1 //위에서 4자리의 숫자라는 검사를 모두 마쳐서 !로 간단하게 처리
                            }
                            return answer
                        } else { throw ErrorCase.inputDuplicateNumber }
                    } else { throw ErrorCase.inputZeroToFirstIndex }
                } else { throw ErrorCase.inputNotFourLength }
            } else { throw ErrorCase.inputString }
        } else { throw ErrorCase.inputNil } //개행 하는 것이 더 보기 불편해보여서 한 줄로 처리.
    }
    
    func receiveContinue() {
        _ = readLine()
    }
}
