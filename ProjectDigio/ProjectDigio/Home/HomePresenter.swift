import Foundation

protocol HomePresentationLogic {
    func presentResponse(_ response: HomeModel.Response)
}

final class HomePresenter {
    private weak var viewController: HomeDisplayLogic?
    
    init(viewController: HomeDisplayLogic?) {
        self.viewController = viewController
    }
}


// MARK: - HomePresentationLogic
extension HomePresenter: HomePresentationLogic {
    func presentResponse(_ response: HomeModel.Response) {
        switch response {
        case .requestProductsResponse(let data):
            presentProducts(data)
        }
    }
}


// MARK: - Private Zone
private extension HomePresenter {
    func presentProducts(_ products: ProductsModel) {
        viewController?.displayProductsViewModel(.displayProductsViewModel(products))
    }
}
