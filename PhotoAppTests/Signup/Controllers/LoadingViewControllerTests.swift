//
//  LoadingViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 03/04/23.
//

import XCTest
@testable import PhotoApp

final class LoadingViewControllerTests: XCTestCase {
    
    var sut: LoadingViewController!

    override func setUpWithError() throws {
        sut = LoadingViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
}
