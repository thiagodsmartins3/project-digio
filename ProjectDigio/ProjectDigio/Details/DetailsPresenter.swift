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
