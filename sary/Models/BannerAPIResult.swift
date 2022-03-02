//
//  BannerAPIResult.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import Foundation

struct BannerAPIResult: Decodable {
    let result: [Banner]
    let status: Bool
}
