//
//  TranslateAPI.swift
//  OpenAPI
//
//  Created by 박희지 on 1/17/24.
//

import Foundation
import Alamofire

class TranslateAPI {
    static func translate(source: String, target: String, text: String, completion: @escaping ((String) -> Void)) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.naver,
                                    "X-Naver-Client-Secret": APIKey.naverSecret]
        
        let parameters: Parameters = ["text": text,
                          "source": source, "target": target]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseDecodable(of: Papago.self) { response in
            switch response.result {
            case .success(let success):
                let papagoData = success.message.result
                dump(success)
                
                completion(papagoData.translatedText)
            case .failure(let failure):
                print("파파고 번역 실패")
                print(failure)
            }
        }
    }
}
