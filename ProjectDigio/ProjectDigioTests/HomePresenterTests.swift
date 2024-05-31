//
//  HomePresenterTests.swift
//  ProjectDigioTests
//
//  Created by Thiago dos Santos Martins on 31/05/24.
//

import XCTest
@testable import ProjectDigio


final class HomePresenterTests: XCTestCase {
    
    private var presenter: HomePresenter!
    private var viewController: HomeViewControllerSpy!
    
    override func setUp() {
        viewController = HomeViewControllerSpy()
        presenter = HomePresenter(viewController: viewController)
    }
    
    override func tearDown() {
        viewController = nil
        presenter = nil
    }
}


// MARK: - Tests
extension HomePresenterTests {
    
}


// MARK: - Spy Classes Setup
private extension HomePresenterTests {
    final class HomeViewControllerSpy: UIViewController, HomeDisplayLogic {
        func displayProductsViewModel(_ viewModel: ProjectDigio.HomeModel.ViewModel) {
            
        }
        
        func displayLoader(_ viewModel: ProjectDigio.LoaderModel.ViewModel) {
            
        }
        
        func displayError() {
            
        }
    }
}
