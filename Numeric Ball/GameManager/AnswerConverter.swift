//
//  AnswerConverter.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/7/24.
//

final class AnswerConverter {
    func convertAnswer(answer input: String) throws -> NumToIndex {
        var validAnswer: NumToIndex = [:]

        guard input.first != "0" else { throw ErrorCase.inputZeroToFirstIndex }//0으로 시작하는 경우
        guard input.allSatisfy({ $0.isNumber }) else { throw ErrorCase.inputString }  //기존 Int()검사로는 -입력을 캐치하지 못했음
        guard input.count == 4 else { throw ErrorCase.inputNotFourLength }//4자리의 문자열이 아닌 경우
        guard Set(input).count == 4 else { throw ErrorCase.inputDuplicateNumber }//중복된 문자가 있는 경우
        
        for (index, number) in input.enumerated() {
            if let validNum = Int(String(number)) {
                validAnswer[validNum] = index + 1
            }
        }
        
        return validAnswer
    }
}
