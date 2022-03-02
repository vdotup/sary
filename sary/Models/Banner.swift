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
    let priority: Int
    let photo: String
    let link: String
    let level: String
    let is_available: Bool
    let branch: Int
}
