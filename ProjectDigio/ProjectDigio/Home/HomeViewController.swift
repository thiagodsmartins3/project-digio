import UIKit

protocol HomeDisplayLogic where Self: UIViewController {
    func displayProductsViewModel(_ viewModel: HomeModel.ViewModel)
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
        view = mainView
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, You should't initialize the ViewController through Storyboards")
    }
}


// MARK: - HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
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
    func sendDataBackToParent(_ data: Data) {
        //usually this delegate takes care of users actions and requests through UI
        
        //do something with the data or message send back from mainView
    }
}


// MARK: - Private Zone
private extension HomeViewController {
    func displayProducts(_ products: ProductsModel) {
        mainView.displayData(products)
        router.routeTo(.xScene(xData: 22))
    }
}
