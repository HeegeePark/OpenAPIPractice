//
//  Book.swift
//  OpenAPI
//
//  Created by 박희지 on 1/18/24.
//

import Foundation

struct Book: Codable {
    let documents: [Document]
//    let meta: Meta
}

struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    // let status: Status
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
}

//struct Meta: Codable {
//    let isEnd: Bool
//    let pageableCount, totalCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case isEnd = "is_end"
//        case pageableCount = "pageable_count"
//        case totalCount = "total_count"
//    }
//}
