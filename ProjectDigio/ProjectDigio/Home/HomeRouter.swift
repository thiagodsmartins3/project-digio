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
        
      case .dismissHomeScene:
        self.dismissHomeScene()
        
      case .xScene(let data):
        self.showXSceneBy(data)
      }
    }
  }
}


// MARK: - Private Zone
private extension HomeRouter {
  
  func dismissHomeScene() {
    viewController?.dismiss(animated: true)
  }
  
  func showXSceneBy(_ data: Int) {
    print("will show the next screen")
  }
}
