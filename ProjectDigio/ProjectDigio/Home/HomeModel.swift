import Foundation

enum HomeModel {
    enum Request {
        case requestProducts
    }
    
    enum Response {
        case requestProductsResponse(_ products: ProductsModel)
    }
    
    enum ViewModel {
        case displayProductsViewModel(_ products: ProductsModel)
    }
    
    enum Route {
        case dismissHomeScene
        case xScene(xData: Int)
    }
    
    struct DataSource {
        //var test: Int
    }
}
