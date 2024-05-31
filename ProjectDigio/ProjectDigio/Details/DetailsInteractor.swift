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
    }
}


// MARK: - DetailsBusinessLogic
extension DetailsInteractor: DetailsBusinessLogic {
    func productInformation(_ request: DetailsModel.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            switch request {
            case .productDetails:
                self.presentDetails(self.dataSource.productDescription, 
                                    image: self.dataSource.productImage)
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
