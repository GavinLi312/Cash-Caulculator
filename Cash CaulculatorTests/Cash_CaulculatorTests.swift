//
//  Cash_CaulculatorTests.swift
//  Cash CaulculatorTests
//
//  Created by Salamender Li on 1/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import XCTest
@testable import Cash_Caulculator

class Cash_CaulculatorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        let fileHelper = FileHelper()
        for item in fileHelper.getAllFileListFromDirectory(){
            fileHelper.deleteImage(imageName: item)
        }
        assert(fileHelper.getAllFileListFromDirectory().count == 0)
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let fileHelper = FileHelper()
        let image = #imageLiteral(resourceName: "GM Logo")
        fileHelper.saveImageWithName(image: image, name: "Test")
        
        
        
        assert(fileHelper.getAllFileListFromDirectory().count != 0)
//        fileHelper.saveImageWithName(image: image, name: "Text Image")
        
        print(fileHelper.getAllFileListFromDirectory())
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
