//
//  StoreTabViewModel.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import Foundation

class StoreTabViewModel {
    
    let banners: [Banner] = Bundle.main.decode(BannerAPIResult.self, from: "banners.json").result
    let catalog: [Catalog] = Bundle.main.decode(CatalogAPIResult.self, from: "catalog.json").result
    
}
