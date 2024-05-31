//
//  DetailsPresenter.swift
//  ProjectDigio
//
//  Created by Thiago dos Santos Martins on 31/05/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the VIP Swift Xcode Templates(https://github.com/Andrei-Popilian/VIP_Design_Xcode_Template)
//  so you can apply clean architecture to your iOS and MacOS projects,
//  see more http://clean-swift.com
//

import Foundation

protocol DetailsPresentationLogic {
    func presentResponse(_ response: DetailsModel.Response)
}

final class DetailsPresenter {
    private weak var viewController: DetailsDisplayLogic?
    
    init(viewController: DetailsDisplayLogic?) {
        self.viewController = viewController
    }
}


// MARK: - DetailsPresentationLogic
extension DetailsPresenter: DetailsPresentationLogic {
    func presentResponse(_ response: DetailsModel.Response) {
        switch response {
        case .presentDetails(let detail, let image):
            presentProductDetails(detail, image: image)
        }
    }
}


// MARK: - Private Zone
private extension DetailsPresenter {
    func presentProductDetails(_ details: String, image: String) { 
        viewController?.displayDetailsViewModel(.displayDetails(detail: details, image: image))
    }
}
