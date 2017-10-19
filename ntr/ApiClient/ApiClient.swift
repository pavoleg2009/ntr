import Foundation

typealias SearchResult = (PoinfOfSale?, String?) -> ()

enum Api {
    static let baseURLString = "https://dl.dropboxusercontent.com/s/f3x990vmoxp5gis/test.json"
}

class ApiClient {
    
    private static let _shared = ApiClient()
    static var shared: ApiClient {
        return _shared
    }
    private init(){}
    
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    
    var pos: PoinfOfSale?
    
    func getSearchResults(completionHandler: @escaping SearchResult) {
        
        dataTask?.cancel()
        
        guard let url = URL(string: Api.baseURLString)
            else { return }
        
        dataTask = session.dataTask(with: url) { (data, response, error) in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage.append("\(error)\n")
            } else if let data = data,
            let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateSearchResults(data)
                DispatchQueue.main.async {
                    completionHandler(self.pos, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
    
    private func updateSearchResults(_ data: Data) {
        var jsonResponse: [String:Any]!
        pos = nil
        
        do {
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        } catch let parseError as NSError {
            errorMessage.append("\(parseError.debugDescription)\n")
            return
        }
        
        pos = PoinfOfSale(json: jsonResponse)
    }
}
