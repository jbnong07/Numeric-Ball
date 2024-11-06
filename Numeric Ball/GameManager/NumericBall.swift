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
    private let gameProcessor: GameProcess//게임을 진행하여 스트라이크와 볼을 알려주는 클래스
    private var gameStatus: GameStatus
    private var gameHistory: GameHistory = GameHistory()//게임 기록을 관리할 수 있는 클래스
    private var roundInfo: RoundHistory = RoundHistory()//라운드와 해당 라운드의 기록을 관리하는 클래스
    private let targetStrikeCount = 4
    
    init(receiver: Receiver = Receiver(),
         printer: Printer = Printer(),
         generator: GeneratorProtocol = AnswerGenerator(),
         processor: GameProcess = GameProcess(), gameStatus: GameStatus = GameStatus()){
        self.receiver = receiver
        self.printer = printer
        self.answerGenerator = generator
        self.gameProcessor = processor
        self.gameStatus = gameStatus
    }
    //함수가 너무 길어 개선할 여지가 있다고 판단됨
    func gameStart() {
        while gameStatus.status == .inGameMenu {
            printer.printMenu()//게임 메뉴 고르기 시작
            do {
                let menuInput = try receiver.receiveMenuSelect()//게임 메뉴 리시브
                printer.printSelectCheck(to: menuInput)//입장한 메뉴 출력
                switch menuInput{
                case .gameStart:
                    gameStatus.updateStatus(to: .gamePlaying)//게임 스테이터스 설정
                    roundInfo = roundInfo.nextRound()//다음 라운드로 진행
                    gameProcessor.setCorrectAnswer(as: answerGenerator.generateAnswer())//정답 생성기로 정답을 생성.
                    
                    while gameStatus.status == .gamePlaying {
                        runningBaseball()
                    }
                    
                    if gameStatus.status == .gameStop { //게임 중단 상태일 시 처음으로 돌아감
                        printer.printGameStopMessage()
                    } else {//히스토리에 이번 회차와 반복 수 입력
                        gameHistory.addGameHistory(reps: roundInfo.tryCount, round: roundInfo.round)
                    }
                    pressAnyKeyToContinue()
                    
                case .gameHistory:
                    printer.printGameHistory(gameHistory.getHistory())//히스토리 출력
                    pressAnyKeyToContinue()
                    
                case .gameExit:
                    gameStatus.updateStatus(to: .stopRunning)
                }
            } catch let error as ErrorCase {
                printer.printErrorMessage(error)
            } catch {
                printer.printErrorMessage(.undefinedError)
            }
        }
    }
    
    private func runningBaseball(){
        do {
            printer.printAnswerRequest()//입력 요청 출력
            if let receiveAnswer = try receiver.receiveAnswer() {//게임 진행 중 q를 누르면 게임 중단
                let strikeAndBall = gameProcessor.gameProcess(receive: receiveAnswer)//스트라이크, 볼 체크
                printer.printStrikeAndBall(to: strikeAndBall)//정답에 따른 문구 출력
                roundInfo = roundInfo.plusTryCount()
                if strikeAndBall == (strike: targetStrikeCount, ball: 0) {//홈런을 치는 경우
                    printer.printTryCount(to: roundInfo.tryCount)
                    gameStatus.updateStatus(to: .gameEnd)//게임 종료
                }
            } else {
                gameStatus.updateStatus(to: .gameStop)//게임 중단
            }
        }
        catch let error as ErrorCase {
            printer.printErrorMessage(error)
        }
        catch {
            printer.printErrorMessage(.undefinedError)
        }
    }
    
    private func pressAnyKeyToContinue(){
        printer.printContinuePressAnyKey()
        receiver.receiveContinue()
        gameStatus.updateStatus(to: .inGameMenu)
    }
}

extension NumericBall {
    struct RoundHistory {//라운드를 쌓아나가고 새로운 라운드마다 카운트 초기화, 기록 시 라운드와 카운트를 읽을 수 있어야 함.
        private(set) var round: Int//private(set)으로 직접적인 수정만 불가능하게 하고 자유롭게 읽을 수 있게 함
        private(set) var tryCount: Int
        
        init(round: Int = 0, tryCount: Int = 0) {//초기화 시 기본값 설정
            self.round = round
            self.tryCount = tryCount
        }
        
        //구조체의 값이 변경되는 게 아니라 새로운 구조체를 반환하는 것으로 불변성을 지키려고 했음.
        //함수를 동사형으로 네이밍하여 의도를 더 정확히 전달하도록 개선해야 함
        func plusTryCount() -> RoundHistory {
            return RoundHistory(round: round, tryCount: tryCount + 1)
        }
        
        func nextRound() -> RoundHistory {
            return RoundHistory(round: self.round + 1, tryCount: 0)
        }
    }
}
