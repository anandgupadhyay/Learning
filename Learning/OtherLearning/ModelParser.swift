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
                completionHandler(.failure(AUIError.dataNotFound))
            }
        } catch {
            AppLogger.appLogs("Error: decodeError: \(error)")
            completionHandler(.failure(AUIError.decoderError))
        }
    }
}

enum AUIError: Error {
    case dataNotFound
    case genericError(Error)
    case contentTypeNotFound
    case failedToCreatePKPass
    case conversationFailed
    case encoderError
    case decoderError
    case passAlreadyInstalled
    case datbaseConnectionFail
    case insertOperationFail
    case deleteOperationFail
    case rowdataNotFound
    case fetchOperationFail
    case norecordFound
    case updateOperationFail
    case saveFileDirectoryFail(Error)
    case fileNotFoundInDirectory
    case removeFileInDirectoryError(Error)
    case unzipFileIntoDirectoryError(Error)
    case retriveFileDataFailed(Error)
}
