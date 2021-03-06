//
//  CatalogApiTest.swift
//  saryTests
//
//  Created by Abdurrahman Alfudeghi on 08/03/2022.
//

import XCTest
import RxSwift
import Alamofire
@testable import sary

class CatalogApiTest: XCTestCase {
    
    var catalogService: CatalogsService!
    let disposeBag = DisposeBag()

    override func setUp() {
        catalogService = CatalogsService()
    }
    
    func test_with_correct_url() {
        
        let exp = expectation(description: "api")
        
        catalogService.test_fetch().subscribe { value in
            guard let response = value.element else { return }
            XCTAssertNil(response.error)
            exp.fulfill()
        }.disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 10)
    }
    
    func test_with_bad_headers_url() {
        let exp = expectation(description: "api")
        
        let headers: HTTPHeaders = [
            "Device-Type": "ios",
            "App-Version": "5.5.0.0.0",
            "Accept-Language": "ar",
            "Platform": "FLAGSHIP"
        ]
        
        catalogService.test_fetch(headers: headers).subscribe { value in
            guard let response = value.element else { return }
            XCTAssertNotNil(response.error)
            exp.fulfill()
        }.disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 10)
    }
    
    func test_with_incorrect_url() {
        // should timeout
        let exp = expectation(description: "api")
        
        catalogService.test_fetch(API: "https://staging.sary.to/api/baskets/313817/catalogs/").subscribe { value in
            guard let response = value.element else { return }
            XCTAssertNotNil(response.error)
            exp.fulfill()
        }.disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 3)
    }

}
