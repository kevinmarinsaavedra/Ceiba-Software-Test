//
//  RequestInterceptorAdapter.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 21/11/23.
//

import Foundation
import Alamofire

class RequestInterceptorAdapter: RequestInterceptor {
    private let sessionDelegate: URLSessionDelegate

    init(_ sessionDelegate: URLSessionDelegate) {
        self.sessionDelegate = sessionDelegate
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        // Puedes agregar lógica de adaptación aquí si es necesario
        // En este caso, simplemente llamamos al método adapt de TestURLSessionDelegate
        sessionDelegate.adapt(urlRequest, for: session, completion: completion)
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Puedes agregar lógica de reintento aquí si es necesario
        // En este caso, simplemente llamamos al método retry de TestURLSessionDelegate
        sessionDelegate.retry(request, for: session, dueTo: error, completion: completion)
    }
}
