//
//  Navalny_Favourite_CartoonTests.swift
//  Navalny Favourite CartoonTests
//
//  Created by Margarita Novokhatskaia on 15/05/2022.
//

import XCTest
import Combine
@testable import Navalny_Favourite_Cartoon

class Navalny_Favourite_CartoonTests: XCTestCase {
    let input = PassthroughSubject<Int, Never>()
    var testViewModel: CharactersViewModelMock!
    var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        let publisher = input.eraseToAnyPublisher()
        testViewModel = CharactersViewModelMock(inputIdentifiersPublisher: publisher)
    }
    
    override func tearDown(){
        subscriptions = []
    }
    
    func testCharacterViewModelExample() throws {
        // Given
        let expected = "Rick Sanchez"
        var result = ""
        let expectation = self.expectation(description: "Characters")
        
        testViewModel.character
            .sink(receiveCompletion: { print($0)},
                  receiveValue: {
                result = $0.name
            })
            .store(in: &subscriptions)
        
        // When
        input.send(1)
        
        testViewModel.testFetchCharacters {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then
        XCTAssert(
            result == expected,
            "Wrong character. Expected: \(expected), result: \(result)"
        )
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class CharactersViewModelMock: CharacterViewModel {
    
    func testFetchCharacters(_ completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion() }
    }
}
