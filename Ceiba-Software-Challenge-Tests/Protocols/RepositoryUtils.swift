//
//  RepositoryUtils.swift
//  Ceiba-Software-Challenge
//
//  Created by Kevin Marin on 1/11/23.
//

import Foundation
@testable import Ceiba_Software_Challenge

protocol RepositoryUtils {
    var filename: String? { get set }
    var throwError: ErrorService? { get set }
}

extension RepositoryUtils {
    
    func parseJsonToObject<T:Decodable>(filename: String, withExtension: String = "json") async throws -> T? {
        
        guard let path = Bundle.main.url(forResource: filename, withExtension: withExtension) else {
            print("Archivo JSON no encontrado.")
            return nil
        }
        
        do {
            // Cargamos el contenido del archivo JSON en un objeto Data.
            let data = try Data(contentsOf: path)
            let jsonDecoder = JSONDecoder()
            
            // Decodifica los datos en un objeto User.
            let result = try jsonDecoder.decode(T.self, from: data)
            
            return result
        } catch {
            print("Error al leer y decodificar el archivo JSON: \(error)")
            return nil
        }
    }
    
    func fetchData<T:Decodable>(_ filename: String?,
                                 _ throwError: ErrorService?,
                                 _ dataDefault: T) async throws -> T {
        do {
            if let filename {
                return try await parseJsonToObject(filename: filename) ?? dataDefault
            }
            
            if let throwError {
                throw throwError
            }
                
            return dataDefault
        } catch {
            throw error
        }
    }
}

