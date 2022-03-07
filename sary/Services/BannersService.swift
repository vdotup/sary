//
//  BannerService.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 07/03/2022.
//

import Foundation
import RxSwift
import Alamofire

protocol BannersServiceProtocol {
    func fetch() -> Observable<[Banner]>
}

class BannersService: BannersServiceProtocol {
    
    let BANNERS_API = "https://staging.sary.to/api/baskets/313817/banners/"

    let headers: HTTPHeaders = [
        "Device-Type": "ios",
        "App-Version": "5.5.0.0.0",
        "Accept-Language": "ar",
        "Authorization": "token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjY5OTE1LCJ1c2VyX3Bob25lIjoiMjAxMDEyNjg2MDI2In0._zbjGr6-HBpc1uaRsu7nvxDiwakwVyRTvD-VRfCcb0Q",
        "Platform": "FLAGSHIP"
    ]
    
    func fetch() -> Observable<[Banner]> {
        return Observable.create { observer -> Disposable in
            
            AF.request(self.BANNERS_API, method: .get, headers: self.headers).responseDecodable(of: BannerAPIResult.self) { response in
                guard let apiResult = response.value else { return }
                observer.onNext(apiResult.result)
            }
            
            return Disposables.create { }
        }
    }
}
