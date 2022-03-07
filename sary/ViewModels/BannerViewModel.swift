//
//  BannerViewModel.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 07/03/2022.
//

import Foundation

struct BannerViewModel {
    
    private let banner: Banner
    
    var image: String {
        return banner.image
    }
    
    init(banner: Banner) {
        self.banner = banner
    }
}
