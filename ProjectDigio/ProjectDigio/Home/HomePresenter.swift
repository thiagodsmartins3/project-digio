import Foundation

protocol HomePresentationLogic {
    func presentResponse(_ response: HomeModel.Response)
    func presentLoader(_ isLoading: LoaderModel.Response)
}

final class HomePresenter {
    private weak var viewController: HomeDisplayLogic?
    
    init(viewController: HomeDisplayLogic?) {
        self.viewController = viewController
    }
}


// MARK: - HomePresentationLogic
extension HomePresenter: HomePresentationLogic {
    func presentLoader(_ isLoading: LoaderModel.Response) {
        switch isLoading {
        case .responseLoader(let loading):
            showLoader(loading)
        }
    }

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
    
    func showLoader(_ isLoading: Bool) {
        viewController?.displayLoader(.displayLoading(isLoading))
    }
}
