//
//  Printer.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

/*
 프린터를 클라이언트에서만 생성한 뒤 각 클래스로 전달할지 각 클래스에서 프린터 인스턴스를 가지도록 주입할지
 또는 클래스별 프린터를 만들어서 각 기능에 맞는 프린터를 주입할지 고민되었음.
 그러나 각 클래스에서 프린터를 가져서 클래스 내부에서 출력 작업이 끝나면 사용할 땐 편하긴 하지만 너무 코드가 복잡해질 거 같다는 생각이 듬
 */
final class Printer {    
    func printStatus(to menu: GameStatus.Status) {
        print(menu.statusMessage,terminator: "")
    }
    
    func printStrikeAndBall(to strikeAndBall: StrikeAndBall) {
        if strikeAndBall.strike == 4 {
            print("\n< ⚾︎!⚾︎!⚾︎!HomeRun!⚾︎!⚾︎!⚾︎ >")
        } else if strikeAndBall == (strike: 0, ball: 0) {
            print("\n< Out >")
        } else {
            print("\n< \(strikeAndBall.strike)S, \(strikeAndBall.ball)B >")
        }
    }
    
    func printAnswerRequest() {
        print("정답을 입력해주세요.(0으로 시작하지 않고 중복되지 않는 4자리의 수) / q를 눌러 포기할 수 있습니다.")
        print("ㄴ",terminator: "")
    }
    
    func printTryCount(to tryCount: Int) {
        print("\n< 이번 라운드 성적은 \(tryCount)회입니다. >")
    }
    
    func printGameHistory(_ rangking: Ranking){
        let sortedRanking = rangking.sorted { $0.key < $1.key}
        var rankingCount: Int = 1
        
        for (reps, round) in sortedRanking {
            print("\(rankingCount)등: \(round)회차 \(reps)회")
            rankingCount += 1
        }
        print("")
    }
    
    func printContinuePressAnyKey(){
        print("메뉴로 돌아가려면 아무 키나 입력하세요.",terminator: "")
    }
    
    func printErrorMessage(_ errorCase: ErrorCase) {
        print(errorCase.rawValue)
    }
    
    func printGameOffError() {
        print("게임 종료에 실패했습니다!")
    }
}
