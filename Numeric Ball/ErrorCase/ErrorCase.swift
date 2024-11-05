//
//  ErrorCode.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

enum ErrorCase: Error {
    case inputBlank //nil 입력 시
    case inputDuplicateNumber//게임 진행 중 중복된 숫자를 입력 시
    case inputZeroToFirstIndex//0을 가장 첫 숫자로 입력 시
    case inputString//문자열을 입력하여 Int로 변환이 안 되는 경우
    case inputInvalidKey//메뉴 선택에 없는 키 입력 시
}
