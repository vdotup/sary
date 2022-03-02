//
//  Catalog.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import Foundation

struct Catalog: Decodable {
    let id: Int
    let title: String
    let data: [CatalogData]
    let data_type: String
    let show_title: Bool
    let ui_type: String
    let row_count: Int
}

struct CatalogData: Decodable {
    let group_id: Int?
    let filters: [CatalogFilter]?
    let name: String?
    let image: String?
    let deep_link: String?
    let empty_content_image: String?
    let empty_content_message: String?
    let has_data: Bool?
    let show_unavailable_items: Bool?
    let show_in_brochure_link: Bool?
}

struct CatalogFilter: Decodable {
    let filter_id: Int
    let name: String
}
