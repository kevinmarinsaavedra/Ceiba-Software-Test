//
//  TestURLSessionDelegate.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 21/11/23.
//

import Foundation
import Alamofire

protocol URLSessionDelegate {
    var delay: TimeInterval { get set}
    
    var simulatedError: AFError? { get set }
        
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void)

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void)
}

class TestURLSession: URLSessionDelegate {
    var delay: TimeInterval = 1.0
    var simulatedError: AFError?

    init() { }
    
    func adapt(_ request: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        // Simular un retraso en la adaptación del request
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                        
            if let error = self.simulatedError {
                // Simular un error
                completion(.failure(error))
            } else {
                // Si no se proporciona ni simulatedData ni simulatedError,
                // simplemente continúa con la solicitud original
                completion(.success(request))
            }
        }
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // No es necesario implementar la lógica de reintentos en este caso
        completion(.doNotRetry)
    }
}
