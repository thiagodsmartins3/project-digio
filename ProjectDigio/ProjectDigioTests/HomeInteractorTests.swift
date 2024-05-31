//
//  HomeInteractorTests.swift
//  ProjectDigioTests
//
//  Created by Thiago dos Santos Martins on 31/05/24.
//

import XCTest
@testable import ProjectDigio

final class HomeInteractorTests: XCTestCase {
    
    private var presenter: HomePresenterSpy!
    private var interactor: HomeInteractor!
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        presenter = nil
        interactor = nil
    }
}


// MARK: - Tests
extension HomeInteractorTests {
    
}

// MARK: - Spy Classes Setup
private extension HomeInteractorTests {
    final class HomePresenterSpy: HomePresentationLogic {
        func presentLoader(_ isLoading: ProjectDigio.LoaderModel.Response) {
            
        }
        
        func presentError() {
            
        }
                
        func presentResponse(_ response: HomeModel.Response) {
            
            switch response {
            case .requestProductsResponse(let products):
                print("")
            }
        }
    }
}
