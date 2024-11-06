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
    func printMenu() {
        print("*****************************************")
        print("원하시는 메뉴를 선택하세요.")
        print("1. ⚾︎게임 시작  /  2. ✎게임 기록  /  q. 게임 나가기 ")
        print("*****************************************")
        print("ㄴ",terminator: "")
    }
    
    func printSelectCheck(to menu: Menu) {
        switch menu {
        case .gameStart:
            print("\n< 게임을 시작합니다! >")
        case .gameHistory:
            print("\n< 게임 기록입니다! >")
        case .gameExit:
            print("\n< 게임을 종료합니다! >")
        }
    }
    
    func printStrikeAndBall(to strikeAndBall: StrikeAndBall) {
        if strikeAndBall.strike == 4 {
            print("\n< ⚾︎!⚾︎!⚾︎!HomeRun!⚾︎!⚾︎!⚾︎ >\n")

        } else if strikeAndBall == (strike: 0, ball: 0) {
            print("\n< Out >\n")
        } else {
            print("\n< \(strikeAndBall.strike)S, \(strikeAndBall.ball)B >\n")
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
    
    func printGameStopMessage() {
        print("\n< 게임을 포기합니다. >\n")
    }
    
    func printContinuePressAnyKey(){
        print("메뉴로 돌아가려면 아무 키나 입력하세요.",terminator: "")
    }
    
    func printErrorMessage(_ errorCase: ErrorCase) {
        switch errorCase {
        case .inputDuplicateNumber:
            print("\n< 중복된 숫자는 불가능합니다! >\n")
        case .inputInvalidMenu:
            print("\n< 선택할 수 없는 메뉴를 입력하셨습니다! >\n")
        case .inputNil:
            print("\n< 입력에 오류가 발생했습니다! >\n")
        case .inputString:
            print("\n< 정수를 정확히 입력해주세요! >\n")
        case .inputZeroToFirstIndex:
            print("\n< 0으로 시작할 수 없습니다! >\n")
        case .undefinedError:
            print("\n< 알 수 없는 오류가 발생했습니다! >\n")
        case .inputNotFourLength:
            print("\n< 4자리를 입력해주세요! >\n")
        }
    }
}
