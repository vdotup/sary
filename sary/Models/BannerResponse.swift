//
//  BannerResponse.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import Foundation

struct BannerResponse: Decodable {
    let result: [Banner]
    let status: Bool
}
