//
//  ErrorCode.swift
//  Numeric Ball
//
//  Created by 박진홍 on 11/4/24.
//

enum ErrorCase: String, Error {
    case inputNil = "\n< 입력에 오류가 발생했습니다! >" //nil 입력 시
    case inputDuplicateNumber = "\n< 중복된 숫자는 불가능합니다! >"//게임 진행 중 중복된 숫자를 입력 시
    case inputZeroToFirstIndex = "\n< 0으로 시작할 수 없습니다! >"//0을 가장 첫 숫자로 입력 시
    case inputString = "\n< 정수를 정확히 입력해주세요! >"//문자열을 입력한 경우
    case inputNotFourLength = "\n< 4자리를 입력해주세요! >"
    case inputInvalidMenu = "\n< 선택할 수 없는 메뉴를 입력하셨습니다! >"//메뉴 선택에 없는 키 입력 시
    case undefinedError = "\n< 알 수 없는 오류가 발생했습니다! >"//알 수 없는 에러 처리 시
    
}
