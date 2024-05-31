//
//  DetailsInteractor.swift
//  ProjectDigio
//
//  Created by Thiago dos Santos Martins on 31/05/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

typealias DetailsInteractable = DetailsBusinessLogic & DetailsDataStore

protocol DetailsBusinessLogic {
    func productInformation(_ request: DetailsModel.Request)
}

protocol DetailsDataStore {
    var dataSource: DetailsModel.DataSource { get }
}

final class DetailsInteractor: DetailsDataStore {
    
    var dataSource: DetailsModel.DataSource
    
    private var presenter: DetailsPresentationLogic
    
    init(viewController: DetailsDisplayLogic?, dataSource: DetailsModel.DataSource) {
        self.dataSource = dataSource
        self.presenter = DetailsPresenter(viewController: viewController)
        print(self.dataSource)
    }
}


// MARK: - DetailsBusinessLogic
extension DetailsInteractor: DetailsBusinessLogic {
    func productInformation(_ request: DetailsModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            switch request {
            case .productDetails:
                self.presentDetails(self.dataSource.productDescription, image: self.dataSource.productImage)
            }
        }
    }
}


// MARK: - Private Zone
private extension DetailsInteractor {
    func presentDetails(_ detail: String, image: String) {
        presenter.presentResponse(.presentDetails(detail: detail, image: image))
    }
}
