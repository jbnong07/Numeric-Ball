//
//  AnswerGenerator.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

//여러 알고리즘 테스트를 위해 프로토콜 설정
protocol GeneratorProtocol {
    
}

class AnswerGenerator: GeneratorProtocol {
    
    
    func generateAnswer() -> NumToIndex{
        
        return [1:1]
    }
}
