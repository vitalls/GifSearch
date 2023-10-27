import Alamofire
class NetworkManager {
    
    static func getGifImages(forString queryTerm: String, completionHandler: @escaping ([Gif]?, AFError?) -> ()) {
        
        let parameters = ["api_key": NetworkConstant.shared.apiKey,
                          "q": queryTerm,
                          "limit": NetworkConstant.shared.gifLimit,
                          "bundle": NetworkConstant.shared.bundle
                        ]
        
        AF.request(NetworkConstant.shared.baseURL, parameters: parameters)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: GifModel.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.gifs, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}

