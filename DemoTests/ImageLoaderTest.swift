//
//  ImageLoaderTest.swift
//  DemoTests
//
//  Created by Vamshi on 17/07/24.
//

import XCTest
import Combine
@testable import Demo

class ImageLoaderTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    func testImageLoader_withValidURL_shouldLoadImage() {
        let expectation = XCTestExpectation(description: "ImageLoader loads image")
        guard let url = URL(string: "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_150.jpg") else {
            XCTFail("Invalid URL")
            return
        }
        
        let loader = ImageLoader(url: url)
        
        loader.$image
            .sink { image in
                if image != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        loader.load()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testImageLoader_withInvalidURL_shouldNotLoadImage() {
        let expectation = XCTestExpectation(description: "ImageLoader does not load image")
        guard let url = URL(string: "https://invalid-url") else {
            XCTFail("Invalid URL")
            return
        }
        
        let loader = ImageLoader(url: url)
        
        loader.$image
            .sink { image in
                if image == nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        loader.load()
        
        wait(for: [expectation], timeout: 5.0)
    }
}
