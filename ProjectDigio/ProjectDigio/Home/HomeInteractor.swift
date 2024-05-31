import Foundation
import RestService

typealias HomeInteractable = HomeBusinessLogic & HomeDataStore

protocol HomeBusinessLogic {
    func request(_ request: HomeModel.Request)
    func showLoader(_ isLoading: LoaderModel.Request)
}

protocol HomeDataStore {
    var dataSource: HomeModel.DataSource { get }
}

final class HomeInteractor: HomeDataStore {
    var dataSource: HomeModel.DataSource
    
    private var presenter: HomePresentationLogic
    
    init(viewController: HomeDisplayLogic?, dataSource: HomeModel.DataSource) {
        self.dataSource = dataSource
        self.presenter = HomePresenter(viewController: viewController)
    }
}


// MARK: - HomeBusinessLogic
extension HomeInteractor: HomeBusinessLogic {
    func showLoader(_ isLoading: LoaderModel.Request) {
        switch isLoading {
        case .requestLoader(let loading):
            showLoading(loading)
        }
    }
    
    func request(_ request: HomeModel.Request) {
        requestHomeData(.requestProducts)
    }
    
    func requestHomeData(_ request: HomeModel.Request) {
        showLoader(.requestLoader(true))
        RestService.shared.request(DigioService.shared.endpoint, requestType: .GET, dataType: ProductsModel.self) {
            result in
            
            switch result {
            case .success(let data):
                self.requestResult(data)
                self.showLoader(.requestLoader(false))
            case .failure(_):
                print("")
            }
        }
    }
}


// MARK: - Private Zone
private extension HomeInteractor {
    func requestResult(_ products: ProductsModel) {
        presenter.presentResponse(.requestProductsResponse(products))
    }
    
    func showLoading(_ isLoading: Bool) {
        presenter.presentLoader(.responseLoader(isLoading))
    }
}
