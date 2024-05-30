import Foundation

protocol HomePresentationLogic {
  func presentResponse(_ response: HomeModel.Response)
}

final class HomePresenter {
  private weak var viewController: HomeDisplayLogic?
  
  init(viewController: HomeDisplayLogic?) {
    self.viewController = viewController
  }
}


// MARK: - HomePresentationLogic
extension HomePresenter: HomePresentationLogic {
  
  func presentResponse(_ response: HomeModel.Response) {
    
    switch response {
      
    case .doSomething(let newItem, let isItem):
      presentDoSomething(newItem, isItem)
    }
  }
}


// MARK: - Private Zone
private extension HomePresenter {
  
  func presentDoSomething(_ newItem: Int, _ isItem: Bool) {
    
    //prepare data for display and send it further
    
    viewController?.displayViewModel(.doSomething(viewModelData: NSObject()))
  }
}
