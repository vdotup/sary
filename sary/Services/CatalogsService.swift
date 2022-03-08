//
//  CatalogsService.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 07/03/2022.
//

import Foundation
import RxSwift
import Alamofire

class CatalogsService {
    
    let CATALOG_API = "https://staging.sary.to/api/baskets/313817/catalog/"

    let headers: HTTPHeaders = [
        "Device-Type": "ios",
        "App-Version": "5.5.0.0.0",
        "Accept-Language": "ar",
        "Authorization": "token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY5OTE1LCJ1c2VyX3Bob25lIjoiMjAxMDEyNjg2MDI2In0._zbjGr6-HBpc1uaRsu7nvxDiwakwVyRTvD-VRfCcb0Q",
        "Platform": "FLAGSHIP"
    ]
    
    func fetch() -> Observable<[Catalog]> {
        return Observable.create { observer -> Disposable in
            
            AF.request(self.CATALOG_API,
                       method: .get,
                       headers: self.headers)
            .responseDecodable(of: CatalogResponse.self) { response in
                guard let apiResult = response.value else { return }
                observer.onNext(apiResult.result)
            }
            return Disposables.create { }
        }
    }
}
