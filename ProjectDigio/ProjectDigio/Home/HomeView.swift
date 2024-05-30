import UIKit

protocol HomeViewDelegate where Self: UIViewController {
  
  func sendDataBackToParent(_ data: Data)
}

final class HomeView: UIView {
  
  weak var delegate: HomeViewDelegate?
  
  private enum ViewTrait {
    static let leftMargin: CGFloat = 10.0
  }
}
