import Foundation

enum DetailsModel {
    
    enum Request {
        case productDetails
    }
    
    enum Response {
        case presentDetails(detail: String, image: String)
    }
    
    enum ViewModel {
        case displayDetails(detail: String, image: String)
    }
    
    enum Route {
        case dismissDetailsScene
        case xScene(xData: Int)
    }
    
    struct DataSource {
        var productDescription: String
        var productImage: String
    }
}
