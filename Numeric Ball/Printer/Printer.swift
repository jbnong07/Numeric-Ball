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
        print("원하시는 메뉴를 선택하세요.")
        print("1. 게임 시작  /  2. 게임 기록  /  q. 게임 나가기")
    }
    
    func printSelectCheck(to menu: String) {
        if menu == "gameStart" {
            print("게임을 시작합니다!")
        } else if menu == "gameHistory" {
            print("게임 기록을 확인합니다!")
        } else if menu == "gameExit" {
            print("게임을 종료합니다!")
        } else {
            
        }
    }
}
