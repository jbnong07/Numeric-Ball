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
    //랜덤한 정답을 만들어주는 클래스
    private let answerGenerator: GeneratorProtocol
    //게임을 진행하여 스트라이크와 볼을 알려주는 클래스
    private let gameProcesser: GameProcess
    //게임 기록을 관리할 수 있는 클래스
    private var gameHistory: GameHistory = GameHistory()
    //현재 회차를 담을 변수
    private var round: Int = 0
    //정답까지의 시도 횟수를 표시
    private var tryCount: Int = 0
    
    //초기화 시 인스턴스 주입
    init(receiver: Receiver = Receiver(),
         printer: Printer = Printer(),
         generator: GeneratorProtocol = AnswerGenerator(),
         processer: GameProcess = GameProcess()){
        self.receiver = receiver
        self.printer = printer
        self.answerGenerator = generator
        self.gameProcesser = processer
    }
    
    //사용자가 사용하게 될 게임 시작 메서드
    func gameStart() {
        var gamePlaying: Bool = true
        while gamePlaying {
            //게임 메뉴 고르기 시작
            printer.printMenu()
            //게임 메뉴 리시브
            do {
                switch try receiver.receiveMenuSelect(){
                case .gameStart:
                    //게임 스테이터스 설정
                    GameStatus.shared.updateStatus(to: .gamePlaying)
                    //라운드 조정
                    self.round += 1
                    //입장한 메뉴 출력
                    printer.printSelectCheck(to: .gameStart)
                    //정답 생성기로 정답을 생성.
                    gameProcesser.setCorrectAnswer(as: answerGenerator.generateAnswer())
                    //정답이 맞다면 반복을 중단하도록 네이밍하고 반복문에 !를 붙임
                    var isCorrectAnswer: Bool = false
                    while !isCorrectAnswer {
                        //입력 요청 출력
                        printer.printAnswerRequest()
                        //게임 진행 중 q를 누를 시 게임 중단처리를 위한 검사
                        if let receiveAnswer = receiver.receiveAnswer() {
                            //정답과 비교 시작
                            let strikeAndBall = gameProcesser.gameProcess(
                                receive: receiveAnswer
                            )
                            //정답에 따른 문구 출력
                            printer.printStrikeAndBall(
                                to: strikeAndBall
                            )
                            tryCount += 1
                            //홈런을 치는 경우 프로세스 종료
                            if strikeAndBall == (strike: 4, ball: 0) {
                                printer.printTryCount(to: tryCount)
                                isCorrectAnswer = true
                            }
                        } else {
                            //게임 중단 문구 출력
                            GameStatus.shared.updateStatus(to: .gameStop)
                            break
                        }
                        
                    }
                    //게임 중단 상태일 시 처음으로 돌아감
                    if GameStatus.shared.gameStatus == .gameStop {
                        GameStatus.shared.updateStatus(to: .inGameMenu)
                        printer.printGameStopMessage()
                        continue
                    }
                    //게임 종료로 스테이터스 설정
                    GameStatus.shared.updateStatus(to: .gameEnd)
                    //히스토리에 이번 회차와 반복 수 입력
                    gameHistory.addGameHistory(reps: tryCount, round: round)
                    //시도 횟수 초기화
                    tryCount = 0
                    //메뉴 선택으로 스테이터스 설정
                    printer.printContinuePressAnyKey()
                    receiver.receiveContinue()
                    GameStatus.shared.updateStatus(to: .inGameMenu)
                    
                case .gameHistory:
                    //입장한 메뉴 출력
                    printer.printSelectCheck(to: .gameHistory)
                    printer.printGameHistory(gameHistory.getHistory())
                    printer.printContinuePressAnyKey()
                    receiver.receiveContinue()
                    
                case .gameExit:
                    //입장한 메뉴 출력
                    printer.printSelectCheck(to: .gameExit)
                    gamePlaying = false
                }
            } catch let error as ErrorCase { //전달받은 에러를 프린터에 다시 전달
                printer.printErrorMessage(error)
            } catch {
                printer.printErrorMessage(.undefinedError)
            }
        }
    }
}

