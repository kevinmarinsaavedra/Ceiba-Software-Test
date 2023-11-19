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

protocol NetworkServiceRequestProtocol {
    func request<T: IEndpoint>(endpoint: T, completion: @escaping (Swift.Result<Data, ErrorService>) -> Void) -> DataRequest?
}

protocol NetworkServiceCancelRequestProtocol {
    func cancelRequest(request: DataRequest, _ completion: (()->Void)?)
}

protocol NetworkServiceCancelAllRequestProtocol {
    func cancelAllRequest(_ completion: (()->Void)?)
}

final class NetworkService {
    static let share = NetworkService()

    private var requests: [DataRequest] = []

    @discardableResult
    private func _dataRequest(url: URLConvertible,
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil) -> DataRequest {
        
        let request = AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            interceptor: interceptor
        )
        
        requests.append(request)
        return request
    }
}

extension NetworkService: NetworkServiceRequestProtocol {
    func request<T: IEndpoint>(endpoint: T, completion: @escaping (Result<Data, ErrorService>) -> Void) -> DataRequest? {
        var dataRequest: DataRequest?
        
        dataRequest = self._dataRequest(url: endpoint.path,
                                        method: endpoint.method,
                                        parameters: endpoint.parameter,
                                        encoding: endpoint.encoding,
                                        headers: endpoint.header,
                                        interceptor: endpoint.interceptor)
        
        DispatchQueue.global(qos: .background).async {
            dataRequest?
                .validate()
                .response(completionHandler: { (response) in
                    switch response.result {
                    case .success(let data):
                        guard let data = data else {
                            let errorDescription = AFError.responseValidationFailed(
                                reason: .dataFileNil
                            ).localizedDescription
                            let error = ErrorService.errorData(description: errorDescription)
                            completion(.failure(error))
                            return
                        }
                        
                        completion(.success(data))
                        
                    case .failure(let error):
                        let error = ErrorService.network(description: error.localizedDescription)
                        completion(.failure(error))
                    }
            })
        }
        
        return dataRequest
    }
}

extension NetworkService: NetworkServiceCancelRequestProtocol {
    
    func cancelRequest(request: DataRequest, _ completion: (() -> Void)?) {
        request.cancel()
        completion?()
    }
}

extension NetworkService: NetworkServiceCancelAllRequestProtocol {
    
    func cancelAllRequest(_ completion: (()->Void)?) {
        requests.forEach {
            $0.cancel()
        }
        requests.removeAll()
        completion?()
    }
}

