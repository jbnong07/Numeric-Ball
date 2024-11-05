
//
//  Typealias.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/5/24.
//

//입력받은 값과 정답을 딕셔너리로 저장할 때 키와 밸류가 정확히 무엇인지 헷갈리지 않도록 이름을 설정함
typealias NumToIndex = [Int:Int]

//스트라이크와 볼의 튜플에 대한 타입 별명 지정
typealias StrikeAndBall = (strike: Int, ball: Int)

//기록은 회차와 시도 횟수를 딕셔너리로 저장하여 가장 시도 횟수가 적은 순으로 랭킹을 표시할 수 있게 함
typealias Ranking = [Int:Int]
