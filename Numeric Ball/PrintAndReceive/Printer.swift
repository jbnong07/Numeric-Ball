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
    
    func printCheatState(isOn: Bool) {
        print(isOn ? "< 치트가 활성화 되었습니다! >\n" : "< 치트가 비활성화 되었습니다! >\n")
    }
    
    func printCorrectAnswer(answer: NumToIndex){
        print("\n< 정답: [",terminator: "")
        let sortedAnswer = answer.sorted { $0.value < $1.value }//인덱스 기준으로 정렬하기
        for num in sortedAnswer{
            print("\(num.key)",terminator: "")
        }
        print("] >")
    }
    
    func printHint(answer: NumToIndex) {
        print("\n< 힌트: [",terminator: "")
        for num in answer{
            print("\(num.key)",terminator: "")
        }
        print("] >")
    }
    
    func printHowToPlay() {
        print("""
        - 목표: 힌트를 이용해 컴퓨터가 정한 숫자를 최대한 적은 시도 횟수로 맞추세요.
          
          - 규칙:
            1. 정답은 중복되지 않는 4자리 숫자로 구성됩니다.
            2. 각 자리의 숫자는 0부터 9까지의 숫자이며, 첫 번째 자리는 0이 될 수 없습니다.
            3. 숫자와 위치가 모두 맞으면 'S(스트라이크)', 숫자만 맞고 위치가 다르면 'B(볼)'로 표시됩니다.
            4. 4 스트라이크를 달성하면 홈런 문구와 함께 게임에서 승리합니다.
          
          - 입력 안내:
            * 4자리 숫자를 입력하고 엔터 키를 눌러 정답을 맞춰보세요.
            * 언제든 'q'를 입력하여 게임을 중단하고 종료할 수 있습니다.
          
          - 힌트 받기:
            * 게임 진행 중 'hint'를 입력하여 정답 숫자 4개를 알 수 있습니다.
            * 4개의 숫자를 알기 위해 필요한 가장 높은 경우의 수 7번이 시도 횟수에 추가됩니다.
          
          - 치트 모드:
            * 메인 메뉴에서 'cheat'를 입력할 경우 게임 기록 비활성화와 함께 매 라운드 정답을 알 수 있습니다.
        
        """)
        
    }
}
