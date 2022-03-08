//
//  CatalogResponse.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import Foundation

struct CatalogResponse: Decodable {
    let result: [Catalog]
    let other: CatalogResponseOther
    let message: String
    let status: Bool
}

struct CatalogResponseOther: Decodable {
    let show_special_order_view: Bool
    let uncompleted_profile_settings: UncompletedProfileSettings
    let show_vat: Bool
    let business_status: BusinessStatus
}

struct UncompletedProfileSettings: Decodable {
    let show_tag: Bool
    let message: String
    let image: String
    let is_completed_profile: Bool
}

struct BusinessStatus: Decodable {
    let id: Int
    let title: String
}
