import Alamofire
import Combine

public class NetworkService<T: Codable> {
    public class func execute(_ urlRequest: URLRequestBuilder, completion: @escaping (Result<T, AFError>) -> Void) -> AnyCancellable {
        
        let requestPublisher = AF.request(urlRequest).publishDecodable(type: T.self)
        let cancellable = requestPublisher.sink { result in
            if let value = result.value {
                completion(Result.success(value))
            } else if let error = result.error {
                completion(Result.failure(error))
            }
        }
        return cancellable
    }
}
