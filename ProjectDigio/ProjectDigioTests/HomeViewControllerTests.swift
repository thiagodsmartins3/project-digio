//
//  HomeViewControllerTests.swift
//  ProjectDigioTests
//
//  Created by Thiago dos Santos Martins on 31/05/24.
//

import XCTest
@testable import ProjectDigio

final class HomeViewControllerTests: XCTestCase {
    private var interactor: HomeInteractorSpy!
    private var viewController: HomeViewController!
    private var router: HomeRouterSpy!
    
    override func setUp() {
        viewController = HomeViewController(mainView: HomeView(), dataSource: HomeModel.DataSource())
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        viewController = nil
        router = nil
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension HomeViewControllerTests {
    
}

// MARK: - Spy Classes Setup
private extension HomeViewControllerTests {
    final class HomeInteractorSpy: HomeInteractable {
        func request(_ request: ProjectDigio.HomeModel.Request) {
            
        }
        
        func showLoader(_ isLoading: ProjectDigio.LoaderModel.Request) {
            
        }
        
        var dataSource: HomeModel.DataSource
        
        var passedEmail: String!
        var passedPassword: String!
        
        init(dataSource: HomeModel.DataSource) {
            self.dataSource = dataSource
        }
        
        func doRequest(_ request: HomeModel.Request) {
            switch request {
            case .requestProducts:
                print("")
            }
        }
    }
    
    final class HomeRouterSpy: HomeRouting {
        
        var passedUserId: String!
        var authenticateSuccessExpectation: XCTestExpectation!
        
        func routeTo(_ route: HomeModel.Route) {
            
            switch route {
            case .productDetail(let detail, let image):
                print("error")
            }
        }
    }
}
