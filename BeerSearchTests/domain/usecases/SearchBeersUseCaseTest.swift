//
//  SearchBeersUseCaseTest.swift
//  BeerSearchTests
//
//  Created by Joaquin Sainz de la Maza on 2020-11-21.
//  Copyright © 2020 Joaquin Sainz de la Maza. All rights reserved.
//

import XCTest

class SearchBeersUseCaseTest: XCTestCase {
    
    //Infraestructure
    static let beers: [Beer] = {
        let beer1 = Beer(id: 1, name: "Cerveza 1", tagline: "", beerDescription: "", imageUrl: "", foodPairing: ["comida1", "comida2"], ABVLevel: 1.3)
        let beer2 = Beer(id: 2, name: "Cerveza 2", tagline: "", beerDescription: "", imageUrl: "", foodPairing: ["comida3", "comida4"], ABVLevel: 5.3)
        return [beer1, beer2]
    }()
    
    enum BeersRepositoryCase: Error {
        case success
        case noResults
        case failure
    }
    
    class BeersRepositoryMock: BeerRepositoryProtocol {
        
        let responseCase:BeersRepositoryCase
        
        init(responseCase: BeersRepositoryCase){
            self.responseCase = responseCase
        }
        
        func getBeers(foodName:String?, ABVMinimumLevel:Float, pageNumber:Int?, numItemsPerPage:Int, completion: @escaping (Response<Beer>) -> Void){
            switch responseCase {
            case .success:
                completion(Response(response: beers, error: nil))
                break
            case .noResults:
                completion(Response(response: [], error: nil))
                break
                
            default:
                completion(Response(response: nil, error: NetworkError(message: "Netwoerk error", code: 500)))
            }
            
        }
    }
    
    //Tests
    func testSearchBeersUseCaseWhenSuccessFetchingData() {
        
        let expectation = self.expectation(description: "2 beers retrieved")
        expectation.expectedFulfillmentCount = 1
        let beersRepository = BeersRepositoryMock(responseCase: .success)
        let useCase = SearchBeersUseCase(repository: beersRepository)
        
        // when
        let requestValue = BeerUseCaseRequestValue(foodName: nil, ABVMinimumLevel: 0.0, pageNumber: 1, numItemsPerPage: 10)
        var beersRetrieved:[Beer]?
        var error:Error?
        useCase.execute(requestValue: requestValue, completion: {
            response in
            beersRetrieved = response.response
            error = response.error
            expectation.fulfill()
            
            
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(beersRetrieved != nil)
        XCTAssertTrue(error == nil)
        XCTAssertTrue(beersRetrieved?.count == 2)
    }
    
    func testSearchBeersUseCaseWhenSuccessAndEmptyFetchingData() {
           
           let expectation = self.expectation(description: "2 beers retrieved")
           expectation.expectedFulfillmentCount = 1
        let beersRepository = BeersRepositoryMock(responseCase: .noResults)
           let useCase = SearchBeersUseCase(repository: beersRepository)
           
           // when
           let requestValue = BeerUseCaseRequestValue(foodName: nil, ABVMinimumLevel: 0.0, pageNumber: 1, numItemsPerPage: 10)
           var beersRetrieved:[Beer]?
           var error:Error?
           useCase.execute(requestValue: requestValue, completion: {
               response in
               beersRetrieved = response.response
               error = response.error
               expectation.fulfill()
               
               
           })
           
           waitForExpectations(timeout: 5, handler: nil)
           XCTAssertTrue(beersRetrieved != nil)
           XCTAssertTrue(error == nil)
           XCTAssertTrue(beersRetrieved?.count == 0)
       }
    
    
    func testSearchBeersUseCaseWhenFailureFetchingData() {
        
        let expectation = self.expectation(description: "No beers retrieved")
        expectation.expectedFulfillmentCount = 1
        let beersRepository = BeersRepositoryMock(responseCase: .failure)
        let useCase = SearchBeersUseCase(repository: beersRepository)
        
        // when
        let requestValue = BeerUseCaseRequestValue(foodName: nil, ABVMinimumLevel: 0.0, pageNumber: 1, numItemsPerPage: 10)
        var beersRetrieved:[Beer]?
        var error:Error?
        useCase.execute(requestValue: requestValue, completion: {
            response in
            beersRetrieved = response.response
            error = response.error
            
            expectation.fulfill()
            
            
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(beersRetrieved == nil)
        XCTAssertTrue(error != nil)
        
    }
    
}
