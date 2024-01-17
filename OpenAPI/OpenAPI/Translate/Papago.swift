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
}
