//
//  StoreTabViewModel.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import Foundation
import RxSwift

final class StoreTabViewModel {
    
    let disposeBag = DisposeBag()
    
    private let bannersService: BannersService
    private let catalogsService: CatalogsService
    
    var banners: [BannerViewModel] = []
    var catalogs: [CatalogViewModel] = []
    
    init(bannersService: BannersService = BannersService(), catalogsService: CatalogsService = CatalogsService()) {
        self.bannersService = bannersService
        self.catalogsService = catalogsService
    }
    
    func fetch() -> Observable<Bool> {
        
        return Observable.create { observer -> Disposable in
            
            self.bannersService.fetch()
                .map { banners in
                    banners.map { BannerViewModel(banner: $0) }
                }
                .subscribe { bannersData in
                    if let bannersVMs = bannersData.element {
                        self.banners = bannersVMs
                        
                        self.catalogsService.fetch()
                            .map { catalogs in
                                catalogs.map { CatalogViewModel(catalog: $0) }
                            }
                            .subscribe { catalogsData in
                                if let catalogsVMs = catalogsData.element {
                                    self.catalogs = catalogsVMs
                                    observer.onCompleted()
                                }
                            }
                            .disposed(by: self.disposeBag)
                    }
                }
                .disposed(by: self.disposeBag)
            
            return Disposables.create { }
        }
    }
    
}
