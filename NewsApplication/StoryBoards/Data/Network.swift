
import Foundation
import Alamofire

class Network {
    func fetchCategoryNews(url: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        AF.request(url).responseDecodable(of: NewsResponse.self.self) { response in
            switch response.result {
            case .success(let newsResponse):
                completion(.success(newsResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
