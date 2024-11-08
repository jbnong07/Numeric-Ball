//
//  Game.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//
/*
 게임 알고리즘
 1. 정답이 generator를 통해 생성되어 세팅된다.
 정답은 딕셔너리로 받는다.
 2. 사용자의 입력을 받는다.
 입력은 4자리의 숫자만 가능하다.
 0이 맨 앞에 있다면 0의 순서에 대한 에러처리
 문자가 입력된다면 문자 입력에 대한 에러처리
 정상적인 입력이 확인되면 시행 횟수에 + 1
 3. 입력받은 숫자와 정답을 비교한다.
 숫자와 위치가 정답과 동일하다면 S += 1
 같은 숫자가 있다면 B += 1
 아무 숫자도 없다면 OUT
 S가 4개라면 HOMERUN
 *비교 알고리즘은 딕셔너리의 키 접근을 이용해서 존재하는지 비교, 존재한다면 밸류에 인덱스를 넣어서 밸류가 동일한지 비교.
 4. 홈런이 나오면 기록에 시행횟수를 추가하고 종료한다.
 5. 게임 중 언제든 q를 입력 받으면 게임을 중단한다.
 */

class NumericBall{
    private let receiver: Receiver
    private let printer: Printer
    private let answerGenerator: GeneratorProtocol//랜덤한 정답을 만들어주는 클래스
    private let answerConverter: AnswerConverter
    private let gameProcessor: GameProcess//게임을 진행하여 스트라이크와 볼을 알려주는 클래스
    private var gameStatus: GameStatus//반복되는 분기 처리를 위한 상태 추적
    private var gameHistory: GameHistory//게임 기록을 관리할 수 있는 구조체
    private var roundInfo: RoundInfo//라운드와 해당 라운드의 기록을 관리하는 구조체
    private let targetStrikeCount = 4
    private var isCheatModeOn: Bool = false //치트 모드의 활성화 여부 체크
    
    init(receiver: Receiver = Receiver(),
         printer: Printer = Printer(),
         generator: GeneratorProtocol = AnswerGenerator(), converter: AnswerConverter = AnswerConverter(),
         processor: GameProcess = GameProcess(), gameStatus: GameStatus = GameStatus(), gameHistory: GameHistory = GameHistory(), roundInfo : RoundInfo = RoundInfo() ){
        self.receiver = receiver
        self.printer = printer
        self.answerGenerator = generator
        self.answerConverter = converter
        self.gameProcessor = processor
        self.gameStatus = gameStatus
        self.gameHistory = gameHistory
        self.roundInfo = roundInfo
    }
    
    //처음에 작성한 코드의 길이가 너무 길어 반복되는 코드와 기능이 구분되는 코드를 메서드로 분리하려 노력
    func gameStart() {
        while gameStatus.status != .menu(.gameOff) {//게임 종료를 선택하기 전까지 반복
            processStatus()
        }
    }
}

extension NumericBall {
    //state에 따른 분기처리
    private func processStatus(){
        printer.printStatus(to: gameStatus.status)//현재 상태 출력
        if let playClosure = getGameFlowDictionary()[gameStatus.status] {//클로저 딕셔너리를 반환받아 상태에 따른 클로저 실행
            do {
                try playClosure()
            } catch let error as ErrorCase {
                printer.printErrorMessage(error)
            } catch {
                printer.printErrorMessage(.undefinedError)
            }
        }
    }
    //스위치 문이 아닌 클로져 딕셔너리로 관리하는 기법을 적용해보려고 함.
    //클래스를 참조하는 과정(강한 참조)에서 순환참조가 발생하여 메모리 누수가 발생할 수 있게 됨 이를 방지하기 위한 코드로 인해 가독성이 떨어져보임.
    //클로저 딕셔너리를 반환하는 메서드를 작성하여 순환참조의 가능성을 낮추고 lazy로 선언한 효과와 비슷하게 만듬 + extension으로 옮겨서 정리
    //치트모드, 힌트모드, 설명페이지 등을 추가하는 과정에서 스위치문보다 추가하고 관리하기 편하다는 느낌을 받음!
    private func getGameFlowDictionary() -> [GameStatus.Status :
    () throws -> Void] {
        return  [
            .menu(.inGameMenu) : {
                [weak self] in
                guard let self = self else { return }
                self.gameStatus.updateStatus(to: try self.receiver.receiveMenuSelect())
            },
            .menu(.gameHistory) : {
                [weak self] in
                guard let self = self else { return }
                self.getHistory()
            },
            .menu(.gameOff) : {
                [weak self] in
                guard let self = self else { return }
                self.printer.printGameOffError()
            },
            .menu(.howToPlay) : {
                [weak self] in
                guard let self = self else { return }
                self.printer.printHowToPlay()
                self.backToMenu()
            },
            .menu(.cheatMode) : {
                [weak self] in
                guard let self = self else { return }
                self.toggleCheatMode()
                self.printer.printCheatState(isOn: self.isCheatModeOn)
                self.gameStatus.updateStatus(to: .menu(.inGameMenu))
            },
            .play(.gameStart) : {
                [weak self] in
                guard let self = self else { return }
                self.startBaseball()
            },
            .play(.gamePlay) : {
                [weak self] in
                guard let self = self else { return }
                try self.runningBaseball()
            },
            .play(.gameStop) : {
                [weak self] in
                guard let self = self else { return }
                self.backToMenu()
            },
            .play(.gameEnd) : {
                [weak self] in
                guard let self = self else { return }
                self.updateRanking()
            }
        ]
    }
    //게임 첫 시작 메서드
    private func startBaseball() {
        gameProcessor.setCorrectAnswer(as: answerGenerator.generateAnswer())
        gameStatus.updateStatus(to: .play(.gamePlay))
        if isCheatModeOn {
            printer.printCorrectAnswer(answer: gameProcessor.gameData.correctAnswer)
        }
    }
    //게임 진행 메서드
    private func runningBaseball() throws {
        printer.printAnswerRequest()//입력 요청 출력
        let receiveAnswer = try receiver.receiveAnswer()
        switch receiveAnswer {
        case "q":
            gameStatus.updateStatus(to: .play(.gameStop))
            roundInfo = roundInfo.nextRound()//라운드 증가
        case "hint":
            roundInfo = roundInfo.plusTryCount(to: 7)
            printer.printHint(answer: gameProcessor.gameData.correctAnswer)
        default:
            let validAnswer = try answerConverter.convertAnswer(answer: receiveAnswer )
            roundInfo = roundInfo.plusTryCount(to: 1)
            checkHomerun(score: gameProcessor.gameProcess(receive: validAnswer))
        }
    }
    //정답 체크
    private func checkHomerun(score: StrikeAndBall){
        printer.printStrikeAndBall(to: score)//정답에 따른 문구 출력
        if score == (strike: targetStrikeCount, ball: 0) {//홈런을 치는 경우
            printer.printTryCount(to: roundInfo.tryCount)
            gameStatus.updateStatus(to: .play(.gameEnd))//게임 종료
        }
    }
    //기록을 보는 메서드
    private func getHistory() {
        printer.printGameHistory(gameHistory.getHistory())//히스토리 출력
        backToMenu()
    }
    //성적을 기록에 추가하는 메서드
    private func updateRanking() {
        if !isCheatModeOn {//치트모드가 켜져있으면 기록 취소
            gameHistory.addGameHistory(reps: roundInfo.tryCount, round: roundInfo.round)//히스토리에 이번 회차와 반복 수 입력
        }
        roundInfo = roundInfo.nextRound()//라운드 증가
        backToMenu()
        
        
    }
    //메인 메뉴로 돌아가는 동작
    private func backToMenu() {
        gameStatus.updateStatus(to: .menu(.inGameMenu))
        pressAnyKeyToContinue()
    }
    //아무 키나 입력을 받는 것으로 진행을 매끄럽게 만들기 위함
    private func pressAnyKeyToContinue() {
        printer.printContinuePressAnyKey()
        receiver.receiveContinue()
    }
    //치트모드 토글
    private func toggleCheatMode() {
        self.isCheatModeOn.toggle()
    }
}
