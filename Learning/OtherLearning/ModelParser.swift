class ModelParser{
    static let shared = ModelParser()
    public init(){
        
    }
    //for generic Parsing added on 20 Dec 2024
    public func genericModelParser<T: Decodable>(data: Data,
                                          dynamicType: T.Type,
                                          completionHandler: @escaping (Result<Any,Error>)-> Void) {
        do{
            if !data.isEmpty {
                let values = try JSONDecoder().decode(dynamicType.self, from: data)
                completionHandler(.success(values))
            }else {
                completionHandler(.failure(WFIError.dataNotFound))
            }
        } catch {
            AppLogger.appLogs("Error: decodeError: \(error)")
            completionHandler(.failure(WFIError.decoderError))
        }
    }
}
