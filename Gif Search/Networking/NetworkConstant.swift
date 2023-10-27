class NetworkConstant {
    //singletone
    static var shared: NetworkConstant = NetworkConstant()
    private init() {}
    
    var baseURL: String {
        return "https://api.giphy.com/v1/gifs/search"
    }
    var apiKey: String {
        return "ry7eT6lOH7UmwsOUV9fhgIQRlcoLRsn9"
    }
    var gifLimit: String {
        return "100"
    }
    var bundle: String {
        return "low_bandwidth"
    }
}

