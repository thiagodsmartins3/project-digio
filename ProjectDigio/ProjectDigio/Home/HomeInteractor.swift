import Foundation

typealias HomeInteractable = HomeBusinessLogic & HomeDataStore

protocol HomeBusinessLogic {
  
  func doRequest(_ request: HomeModel.Request)
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
  
  func doRequest(_ request: HomeModel.Request) {
    DispatchQueue.global(qos: .userInitiated).async {
      
      switch request {
        
      case .doSomething(let item):
        self.doSomething(item)
      }
    }
  }
}


// MARK: - Private Zone
private extension HomeInteractor {
  
  func doSomething(_ item: Int) {
    
    //construct the Service right before using it
    //let serviceX = factory.makeXService()
    
    // get new data async or sync
    //let newData = serviceX.getNewData()
    
    presenter.presentResponse(.doSomething(newItem: item + 1, isItem: true))
  }
}
