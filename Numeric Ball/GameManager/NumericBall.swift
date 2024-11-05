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
protocol GameManagerProtocol{
    
}



class NumericBall{
    private let receiver: Receiver
    private let printer: Printer
    private let answerGenerator: GeneratorProtocol
    private let gameProcesser: GameProcess
    private var gameHistory: GameHistory
    
    init(receiver: Receiver = Receiver(), printer: Printer = Printer(), generator: GeneratorProtocol = AnswerGenerator(),processer: GameProcess = GameProcess()){
        self.receiver = receiver
        self.printer = printer
        self.answerGenerator = generator
        self.gameProcesser = processer
    }
    
    func gameStart() {
        var isContinue: Bool = true
        
        while isContinue {
            //게임 메뉴 고르기 프린트
            //게임 메뉴 리시브
            //게임 시작
            //정답 데이터 설정
            //인풋
            
        }
    }
}

