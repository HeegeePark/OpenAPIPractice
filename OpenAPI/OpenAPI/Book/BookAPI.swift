//
//  BookAPI.swift
//  OpenAPI
//
//  Created by 박희지 on 1/18/24.
//

import Foundation
import Alamofire

class BookAPI {
    static func getSearchResult(text: String, _ completion: @escaping ([Document]) -> Void) {
        // 한글 검색 안될 때
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        
        let headers: HTTPHeaders = ["Authorization": APIKey.kakao]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                completion(success.documents)
                
            case .failure(let failure):
                print("카카오 북 검색 실패")
                print(failure)
            }
        }
    }
}
