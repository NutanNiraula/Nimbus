//
//  NimbusTests.swift
//  NimbusTests
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import XCTest
@testable import Nimbus

class NimbusTests: BaseXCTest {
    
    var sut: ViewModel!

    override func setUp() {
        sut = ViewModel(todoFetchServiceEndPoint: ToDoDataEndPoint(), imageFetchServiceEndPoint: PlaceHolderImageEndPoint(), networkFactory: NetworkCallerFactory(callerType: .mockHttp(mockCaller: mockNetworkCaller)))
    }

    override func tearDown() {
        sut = nil
    }

    func test_getData_whenNetworkCallIsSuccessful_triggersDataModelCallback() {
        mockNetworkCaller.response = .success(jsonFileName: "Success")
        //should use await, if the datamodel closure is not call test can pass by mistake
        sut.dataModel = { data in
            XCTAssertEqual(data.title, "title")
            XCTAssertEqual(data.isCompleted, false)
        }
        sut.getData()
    }

}
