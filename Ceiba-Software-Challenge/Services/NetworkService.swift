//
//  NetworkService.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 18/9/21.
//

import Foundation

import Alamofire

protocol IEndpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameter: Parameters? { get }
    var header: HTTPHeaders? { get }
    var interceptor: RequestInterceptor? { get }
    var encoding: ParameterEncoding { get }
}

final class NetworkService {
    static let share = NetworkService()
    
    private var dataRequest: DataRequest?
    
    @discardableResult
    private func _dataRequest(url: URLConvertible,
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil) -> DataRequest {
        
            return Session.default.request(url,
                                           method: method,
                                           parameters: parameters,
                                           encoding: encoding,
                                           headers: headers,
                                           interceptor: interceptor)
    }
    
    func request<T: IEndpoint>(endpoint: T, completion: @escaping (Swift.Result<Data, ErrorService>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var dataRequest: DataRequest?
            
            dataRequest = self._dataRequest(url: endpoint.path,
                                            method: endpoint.method,
                                            parameters: endpoint.parameter,
                                            encoding: endpoint.encoding,
                                            headers: endpoint.header,
                                            interceptor: endpoint.interceptor)
            
            dataRequest?
                .validate()
                .response(completionHandler: { (response) in
                    
                    switch response.result {
                    case .success(let data):
                        guard (response.response?.statusCode) != nil else {
                            completion(
                                .failure(
                                    .network(
                                        description: AFError.responseValidationFailed(
                                            reason: .unacceptableStatusCode(code: 0)
                                        ).localizedDescription
                                    )
                                )
                            )
                            
                            return
                        }
                        
                        guard let data = data else {
                            completion(
                                .failure(
                                    .network(
                                        description: AFError.responseValidationFailed(
                                            reason: .dataFileNil
                                        ).localizedDescription
                                    )
                                )
                            )
                            return
                        }
                        
                        completion(.success(data))
                        
                    case .failure(let error):
                        
                        completion(
                            .failure(
                                .network(description: error.localizedDescription)
                            )
                        )
                    }
            })
        }
    }
        
    func cancelRequest(_ completion: (()->Void)? = nil) {
        dataRequest?.cancel()
        completion?()
    }
    
    func cancelAllRequest(_ completion: (()->Void)? = nil) {
        dataRequest?.tasks.forEach({ (task) in
            task.cancel()
        })
        completion?()
    }
}
