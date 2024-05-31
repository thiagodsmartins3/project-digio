import UIKit

protocol DetailsRouting {
    func routeTo(_ route: DetailsModel.Route)
}

final class DetailsRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}


// MARK: - DetailsRouting
extension DetailsRouter: DetailsRouting {
    func routeTo(_ route: DetailsModel.Route) {
        DispatchQueue.main.async {

        }
    }
}

// MARK: - Private Zone
private extension DetailsRouter {
    
}
