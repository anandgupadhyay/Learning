class APIManager {
    static let shared = APIManager()
    private init() {}

    
    /// Call API
    /// - Parameters:
    ///   - requestType: request type get/post/put
    ///   - apiUrl: Web service URL
    ///   - parameters: Paremeters
    ///   - responseModel: response Model
    ///   - completion: completion Handler
    func callAPI<T>(requestType: Alamofire.HTTPMethod, apiUrl: String?, parameters:[String:Any]?,responseModel: T.Type? = nil, completion: @escaping (_ success: Bool, _ responseModel: T?) -> Void) where T: Codable {
        let formattedApiUrl = apiUrl?.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: formattedApiUrl ?? "") else { return }
                
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        //requestType == .get ? : JSONEncoding.default
        AF.request(url,method: requestType, parameters: parameters,encoding:  URLEncoding.default , headers:nil).responseData(completionHandler: {response in
//            do{
            switch response.result{
            case .success(let res):
//                let string = String(data: res, encoding: .utf8) ?? ""
                if let code = response.response?.statusCode{
                    switch code{
                    case 200...299:
                            do {
                                let response =  try JSONDecoder().decode(T.self, from: res)
                                completion(true, response)
                            } catch _ {
                                completion(false, nil)
                            }
                    default:
                        completion(false, nil)
                    }
                }else{
                    completion(false, nil)
                }
            case .failure(_):
                completion(false, nil)
            }
//            } catch {
//            AppLogger.appLogs("Error: \(error)")
//            completion(false, nil)
//        }
        })
    }
    
    func sendRequestWithoutModel(requestType: Alamofire.HTTPMethod, apiUrl: String?, parameters:[String:String], needHeader isNeededHeader:Bool, completion: @escaping (_ success: Bool, _ dictionary: [String : Any]?) -> Void){
        
        
        let formattedApiUrl = apiUrl?.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: formattedApiUrl ?? "") else { return }
        
        var agent = ""
//        let deviceType = getCurrentDeviceType()
        agent = String(format: Headers.rAgent, getUserAgentTypeForNotification())
//        APPDELEGATE.objHome?.showSnackbarAlert(message: agent, type: .warning,show: true,controller: UIApplication.shared.visibleViewController!)

        let headers: HTTPHeaders = [
            .accept("application/json"),
            .userAgent(agent)
        ]
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 120

        AF.request(url,method: requestType, parameters: parameters,encoding: requestType == .get ? URLEncoding.default : JSONEncoding.default, headers: isNeededHeader == true ? headers : nil).responseData(completionHandler: {response in
            switch response.result{
            case .success(let res):
//                Print.Print(String(data: res, encoding: .utf8) ?? "nothing received",isPrint: true)
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
//                        do {
                            let dictionary = (try? JSONSerialization.jsonObject(with: res, options: [])) as? [String : Any]
                            if dictionary != nil{
                                completion(true,dictionary)
                            }else{
                                completion(false,nil)
                            }
//                            completion(true, try JSONDecoder().decode(T.self, from: res))
//                        } catch _ {
//                            completion(false, [:])
//                        }
                    default:
                        completion(false, nil)
                    }
                }
            case .failure(_):
                completion(false, nil)
            }
        })
    }
    
        /// Makes an API call and decodes the JSON response dynamically
        /// - Parameters:
        ///   - urlString: The API endpoint URL
        ///   - parameters: A dictionary of query parameters
        ///   - responseType: The type of response expected
        ///   - completion: A completion handler with the result (success or failure)
        func fetchData<T: Decodable>(
            from urlString: String,
            parameters: [String: String]?,
            responseType: T.Type,
            completion: @escaping (Result<T, APIError>) -> Void
        ) {
            // Construct the URL with query parameters
            guard var urlComponents = URLComponents(string: urlString) else {
                completion(.failure(.invalidURL))
                return
            }
            
            if let parameters = parameters {
                urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
            
            guard let url = urlComponents.url else {
                completion(.failure(.invalidURL))
                return
            }
            
            // Create the URL request
            let request = URLRequest(url: url)
            
            // Perform the network call
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle errors
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                
                // Validate response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                // Decode the JSON
                guard let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let decodingError {
                    completion(.failure(.decodingFailed(decodingError)))
                }
            }.resume()
        }
    
}
