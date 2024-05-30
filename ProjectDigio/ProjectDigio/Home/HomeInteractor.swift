import Foundation
import RestService

typealias HomeInteractable = HomeBusinessLogic & HomeDataStore

protocol HomeBusinessLogic {
    func request(_ request: HomeModel.Request)
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
    func request(_ request: HomeModel.Request) {
        requestHomeData(.requestProducts)
    }
    
    func requestHomeData(_ request: HomeModel.Request) {
        RestService.shared.request(DigioService.shared.endpoint, requestType: .GET, dataType: ProductsModel.self) {
            result in
            
            switch result {
            case .success(let data):
                self.requestResult(data)
            case .failure(let error):
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
}
