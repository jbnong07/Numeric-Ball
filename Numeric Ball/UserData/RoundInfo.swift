//
//  RoundHistory.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/7/24.
//
struct RoundInfo {//라운드를 쌓아나가고 새로운 라운드마다 카운트 초기화, 기록 시 라운드와 카운트를 읽을 수 있어야 함.
    private(set) var round: Int//private(set)으로 직접적인 수정만 불가능하게 하고 자유롭게 읽을 수 있게 함
    private(set) var tryCount: Int
    
    init(round: Int = 1, tryCount: Int = 0) {//초기화 시 기본값 설정
        self.round = round
        self.tryCount = tryCount
    }
    
    //구조체의 값이 변경되는 게 아니라 새로운 구조체를 반환하는 것으로 불변성을 지키려고 했음.
    //이번 구조처럼 조건없는 간단한 변경은 불필요한 메모리 할당일 수 있다고 생각함 mutating을 사용하는 것이 더 나을 수도 있음.
    //함수를 동사형으로 네이밍하여 의도를 더 정확히 전달하도록 개선해야 함
    func plusTryCount() -> RoundInfo {
        return RoundInfo(round: round, tryCount: tryCount + 1)
    }
    
    func nextRound() -> RoundInfo {
        return RoundInfo(round: self.round + 1, tryCount: 0)
    }
}
