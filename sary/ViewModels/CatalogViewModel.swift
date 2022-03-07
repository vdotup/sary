//
//  CatalogViewModel.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 07/03/2022.
//

import Foundation

struct CatalogViewModel {
    
    private let catalog: Catalog
    
    var title: String {
        return catalog.title!
    }
    
    var data: [CatalogData] {
        return catalog.data
    }
    
    var data_type: Catalog.CatalogType {
        return catalog.data_type
    }
    
    var row_count: Int {
        return catalog.row_count
    }
    
    init(catalog: Catalog) {
        self.catalog = catalog
    }
}
