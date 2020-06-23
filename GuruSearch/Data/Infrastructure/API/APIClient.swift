//
//  APIClient.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Alamofire

enum APIClient {
    
    /// API Request
    static func request<T: APIRequestable>(request: T,
                                           queue: DispatchQueue = .main,
                                           decoder: DataDecoder = defaultDataDecoder(),
                                           completion: @escaping(Swift.Result<T.Response, APIError<T>>) -> Void) {
        
        guard let urlRequest = request.makeURLRequest() else {
            completion(.failure(.invalidRequest))
            return
        }
        print("urlRequest")
        dump(urlRequest)
        
        let dataRequest = AF.request(urlRequest)
            .validate(statusCode: 200..<600)
            .responseDecodable(of: T.Response.self, queue: queue, decoder: decoder) { dataResponse in
                
                let httpURLResponse = dataResponse.response
                let afError = dataResponse.error
                // Verify http status code.
                if let statusCodeError = verifyResponseStatusCode(response: httpURLResponse, afError: afError, request: request) {
                    completion(.failure(statusCodeError))
                    return
                }
                
                // Whether response data is nil.
                guard let data = dataResponse.data else {
                    let apiError = afErrorToAPIError(afError: afError, request: request)
                    completion(.failure(apiError))
                    return
                }
                
                switch dataResponse.result {
                case .success(let response):
                    print("API Response")
                    dump(response)
                    completion(.success(response))
                    
                case .failure(let afError):

                    print("afError", afError)
                    
                    // Whether the error object is `.responseSerializationFailed`.
                    if afError.isResponseSerializationError {
                        let apiError = decodeErrorResponse(errorResponseData: data, request: request)
                        completion(.failure(apiError))
                        return
                    }
                    
                    let apiError = afErrorToAPIError(afError: afError, request: request)
                    completion(.failure(apiError))
                }
        }
        
        // Add dataRequest to APICanceler.
        APICanceller.shared.append(dataRequest: dataRequest)
    }
    
    private static func defaultDataDecoder() -> DataDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoder: DataDecoder = jsonDecoder
        return decoder
    }
    
    /// Verify http status code.
    private static func verifyResponseStatusCode<T: APIRequestable>(response: HTTPURLResponse?, afError: AFError?, request: T) -> APIError<T>? {
        guard let status = response?.status else {
            let apiError = afErrorToAPIError(afError: afError, request: request)
            return apiError
        }
        print("HTTP status", status)
        
        switch status {
        case .unauthorized:
            return .unauthorized
        case .forbidden:
            return .forbidden
        default:
            break
        }
        return nil
    }
    
    /// Convert error type from AFError to APIError.
    private static func afErrorToAPIError<T: APIRequestable>(afError: AFError?, request: T) -> APIError<T> {
        
        guard let afError = afError else {
            print("data and error are nil.")
            return .invalidResponse
        }
        print("AFError:\(afError)")
        
        if afError.isExplicitlyCancelledError {
            print("request is cancelled.")
            return .cancelled
        }
        
        if case .sessionTaskFailed(error: let error) = afError {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    return .connectionError
                case .timedOut:
                    return .timedOut
                default:
                    break
                }
            }
        }
        return .others(error: afError)
    }
    
    /// Decode the error response data.
    ///
    /// - Parameters:
    ///   - errorResponseData: API error data
    ///   - request: APIRequest
    /// - Returns: APIError
    private static func decodeErrorResponse<T: APIRequestable>(errorResponseData: Data, request: T) -> APIError<T> {
        if let apiErrorObject = request.decode(errorResponseData: errorResponseData) {
            print("apiErrorObject:\(apiErrorObject)")
            return .errorResponse(errObject: apiErrorObject)
        }
        print("Decoding failure.")
        return .decodeError
    }
}
