//
//  Banner.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import Foundation

struct Banner: Decodable {
    let id: Int
    let title: String
    let description: String
    let button_text: String
    let expiry_status: Bool
    let created_at: String
    let start_date: String
    let expiry_date: String
    let image: String
    let photo: String
    let promo_code: String?
    let priority: Int
    let link: String?
    let level: String
    let is_available: Bool
    let branches: [String]?
    var cities: [Int]?
}
