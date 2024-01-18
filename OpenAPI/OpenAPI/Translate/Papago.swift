//
//  Papago.swift
//  OpenAPI
//
//  Created by 박희지 on 1/17/24.
//

import Foundation

/*
 {
     "message": {
         "@type": "response",
         "@service": "naverservice.nmt.proxy",
         "@version": "1.0.0",
         "result": {
             "srcLangType": "ko",
             "tarLangType": "en",
             "translatedText": "I'm thinking about it.",
             "engineType": "PRETRANS"
         }
     }
 }
 */

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapagoData
}

struct PapagoData: Codable {
    let translatedText: String
}

enum Language {
    static let code: [String: String] = [
        "ko": "한국어",
        "en": "영어",
        "ja": "일본어",
        "zh-CN": "중국어 간체",
        "zh-TW": "중국어 번체",
        "vi": "베트남어",
        "id": "인도네시아어",
        "th": "태국어",
        "de": "독일어",
        "ru": "러시아어",
        "es": "스페인어",
        "it": "이탈리아어",
        "fr": "프랑스어"
    ]
    
    static var orderedKey: [Int: String] {
        var dict = [Int: String]()
        for key in code.keys {
            switch key {
            case "ko":
                dict[0] = key
            case "en":
                dict[1] = key
            case "ja":
                dict[2] = key
            case "zh-CN":
                dict[3] = key
            case "zh-TW":
                dict[4] = key
            case "vi":
                dict[5] = key
            case "id":
                dict[6] = key
            case "th":
                dict[7] = key
            case "de":
                dict[8] = key
            case "ru":
                dict[9] = key
            case "es":
                dict[10] = key
            case "it":
                dict[11] = key
            default:
                dict[12] = key
            }
        }
        return dict
    }
    
    static subscript(i: Int) -> String {
        return code[orderedKey[i]!]!
    }
    
    // sorted로 순서를 보장한 딕셔너리
    // index로 딕셔너리 item에 접근 가능.
    static var orderedCode: [Dictionary<String, String>.Element] {
        return code.sorted {
            $0.key < $1.key
        }
    }
}
