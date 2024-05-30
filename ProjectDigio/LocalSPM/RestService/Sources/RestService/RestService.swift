import Foundation
import UIKit

public enum RestServiceRequestType {
    case GET
    case POST
}

public enum RestServiceRequetError: Error {
    case conversionError
    case requestError
    
    public var message: String {
        switch self {
        case .conversionError:
            return "Data error"
        case .requestError:
            return "Request Error"
        }
    }
}

public class RestService {
    public static let shared = RestService()
    
    private init() { }
    
    public func request<T: Decodable>(_ endpoint: String,
                                      requestType: RestServiceRequestType,
                                      dataType: T.Type,
                                      result: @escaping (Result<T, RestServiceRequetError>) -> Void) {
        if let url = URL(string: endpoint) {
            let task = URLSession.shared.dataTask(with: url) {  [weak self] data, response, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    result(.failure(.requestError))
                } else if let data = data {
                    print("Data received: \(data)")
                    
                    self.decodeRequest(data, decodeTo: dataType) {
                        decodeResult in
                        
                        switch decodeResult {
                        case .success(let data):
                            result(.success(data))
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    public func downloadImage(_ url: String,
                              completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error!))
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            completionHandler(.success(downloadedImage))
                        }
                    }
                }
            }).resume()
        }
    }
    
    private func decodeRequest<T: Decodable>(_ data: Data?,
                                             decodeTo: T.Type,
                                             conversionResult: (Result<T, RestServiceRequetError>) -> Void) {
        if let data = data {
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                conversionResult(.success(decodedObject))
            } catch {
                conversionResult(.failure(.conversionError))
            }
        }
    }
}
