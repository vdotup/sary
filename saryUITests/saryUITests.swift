//
//  saryUITests.swift
//  saryUITests
//
//  Created by Abdurrahman Alfudeghi on 02/03/2022.
//

import XCTest

class saryUITests: XCTestCase {
    
    func testUI() {
        
        let app = XCUIApplication()
        app.launch()
        
        sleep(5)
        
        app.navigationBars["sary.TabBar"].buttons["cart"].tap()
        app.alerts["سلة الشراء فارغة"].scrollViews.otherElements.buttons["موافق"].tap()
        
        let tabBar = app.tabBars["شريط علامات التبويب"]
        let button = tabBar.buttons["الطلبات"]
        button.tap()
        tabBar.buttons["صفحتي"].tap()
        button.tap()
        tabBar.buttons["المتجر"].tap()
                
        
    }
}
