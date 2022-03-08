//
//  CatalogsService.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 07/03/2022.
//

import Foundation
import RxSwift
import Alamofire

let CATALOG_API = "https://staging.sary.to/api/baskets/313817/catalog/"
let API_HEADERS: HTTPHeaders = [
    "Device-Type": "ios",
    "App-Version": "5.5.0.0.0",
    "Accept-Language": "ar",
    "Authorization": "token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY5OTE1LCJ1c2VyX3Bob25lIjoiMjAxMDEyNjg2MDI2In0._zbjGr6-HBpc1uaRsu7nvxDiwakwVyRTvD-VRfCcb0Q",
    "Platform": "FLAGSHIP"
]

class CatalogsService {
    
    func fetch() -> Observable<[Catalog]> {
        return Observable.create { observer -> Disposable in
            
            AF.request(CATALOG_API,
                       method: .get,
                       headers: API_HEADERS)
            .responseDecodable(of: CatalogResponse.self) { response in
                guard let apiResult = response.value else { return }
                observer.onNext(apiResult.result)
            }
            return Disposables.create { }
        }
    }
    
    func test_fetch(API: String = CATALOG_API, headers: HTTPHeaders = API_HEADERS) -> Observable<DataResponse<CatalogResponse, AFError>> {
        return Observable.create { observer -> Disposable in
            
            AF.request(API,
                       method: .get,
                       headers: headers)
            .responseDecodable(of: CatalogResponse.self) { response in
                observer.onNext(response)
            }
            return Disposables.create { }
        }
    }
    
}
