import UIKit

protocol DetailsDisplayLogic where Self: UIViewController {
    func displayDetailsViewModel(_ viewModel: DetailsModel.ViewModel)
}

final class DetailsViewController: UIViewController {
    
    private let mainView: DetailsView
    private var interactor: DetailsInteractable!
    private var router: DetailsRouting!
    
    init(mainView: DetailsView, dataSource: DetailsModel.DataSource) {
        self.mainView = mainView
        
        super.init(nibName: nil, bundle: nil)
        interactor = DetailsInteractor(viewController: self, dataSource: dataSource)
        router = DetailsRouter(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.productInformation(.productDetails)
    }
    
    override func loadView() {
        mainView.delegate = self
        view = mainView
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, You should't initialize the ViewController through Storyboards")
    }
}


// MARK: - DetailsDisplayLogic
extension DetailsViewController: DetailsDisplayLogic {
    func displayDetailsViewModel(_ viewModel: DetailsModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .displayDetails(let detail, let image):
                self.displayProductDetails(detail, image: image)
            }
        }
    }
}

// MARK: - DetailsViewDelegate
extension DetailsViewController: DetailsViewDelegate {
    func displayProductDetail(_ description: String, image: String) {
        
    }
}


// MARK: - Private Zone
private extension DetailsViewController {
    func displayProductDetails(_ description: String, image: String) {
        mainView.displayProducts(description, image: image)
    }
}
