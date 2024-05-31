import UIKit

protocol HomeRouting {
    func routeTo(_ route: HomeModel.Route)
}

final class HomeRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}


// MARK: - HomeRouting
extension HomeRouter: HomeRouting {
    func routeTo(_ route: HomeModel.Route) {
        DispatchQueue.main.async {
            switch route {
            case .productDetail(let data, let image):
                self.routeToDetails(data, image: image)
            }
        }
    }
}

// MARK: - Private Zone
private extension HomeRouter {
    func routeToDetails(_ description: String, image: String) {
        let detailsViewController = DetailsViewController(mainView: DetailsView(), dataSource: DetailsModel.DataSource(productDescription: description, productImage: image))
        viewController?.modalPresentationStyle = .formSheet
        viewController?.present(detailsViewController, animated: true)
    }
}
