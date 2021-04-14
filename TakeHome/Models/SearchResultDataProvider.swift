
import Foundation
import Alamofire

final class SearchResultDataProvider {
    
    //MARK: - Constants

    private let link = "https://601f1754b5a0e9001706a292.mockapi.io/podcasts"
    
    //MARK: - Methods

    public func getSearch(page: Int, query: String, success: @escaping ([Podcast]) -> Void, failure: @escaping (Error?) -> Void) {
        let searchLink = link + "?p=\(page)&l=10" + "&search=" + query
        
        AF.request(searchLink).validate().responseDecodable(of: [Podcast].self) { response in
            guard let receivedList = response.value else {
                failure(response.error)
                return
            }
            if !receivedList.isEmpty {
                success(receivedList)
            } else {
                failure(response.error)
            }
        }
    }
}
