//
//  CatalogAPIResult.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import Foundation

struct CatalogAPIResult: Decodable {
    let result: [Catalog]
    let message: String
    let status: Bool
}
