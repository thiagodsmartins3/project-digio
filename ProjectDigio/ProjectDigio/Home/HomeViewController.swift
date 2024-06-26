import UIKit

protocol HomeDisplayLogic where Self: UIViewController {
    func displayProductsViewModel(_ viewModel: HomeModel.ViewModel)
    func displayLoader(_ viewModel: LoaderModel.ViewModel)
    func displayError()
}

final class HomeViewController: UIViewController {
    
    private let mainView: HomeView
    private var interactor: HomeInteractable!
    private var router: HomeRouting!
    
    init(mainView: HomeView, dataSource: HomeModel.DataSource) {
        self.mainView = mainView
        
        super.init(nibName: nil, bundle: nil)
        interactor = HomeInteractor(viewController: self, dataSource: dataSource)
        router = HomeRouter(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.request(.requestProducts)
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


// MARK: - HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayError() {
        showError()
    }
    
    func displayLoader(_ viewModel: LoaderModel.ViewModel) {
        switch viewModel {
        case .displayLoading(let loading):
            showLoading(loading)
        }
    }

    func displayProductsViewModel(_ viewModel: HomeModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .displayProductsViewModel(let data):
                self.displayProducts(data)
            }
        }
    }
}


// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {    
    func didSelectProduct(_ description: String, image: String) {
        router.routeTo(.productDetail(description, productImage: image))
    }
}


// MARK: - Private Zone
private extension HomeViewController {
    func displayProducts(_ products: ProductsModel) {
        mainView.displayData(products)
    }
    
    func showLoading(_ isLoading: Bool) {
        mainView.displayLoading(isLoading)
    }
    
    func showError() {
        mainView.displayError()
    }
}
