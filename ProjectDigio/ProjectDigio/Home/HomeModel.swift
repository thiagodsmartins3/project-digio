import Foundation

enum HomeModel {
  
  enum Request {
    case doSomething(item: Int)
  }
  
  enum Response {
    case doSomething(newItem: Int, isItem: Bool)
  }
  
  enum ViewModel {
    case doSomething(viewModelData: NSObject)
  }
  
  enum Route {
    case dismissHomeScene
    case xScene(xData: Int)
  }
  
  struct DataSource {
    //var test: Int
  }
}
