//
//  NetworkingServiceWithCompletion.swift
//  Random Nums
//
//  Created by MaxOS on 30.07.2023.
//

import Foundation

class NetworkingServiceWithCompletion {
    static let shared = NetworkingServiceWithCompletion(); private init() { }
    
    private func createURL() -> URL? {
        let tunnel = "https://"
        let server = "api.rand.by"
        let versionAPI = "/v1"
        let endpoint = "/geo"
        
        let stringUrl = tunnel + server + versionAPI + endpoint
        
        let url = URL(string: stringUrl)
        return url
    }
    
    func fetchData(completion: @escaping (Result<Items, Error>) -> ()) {
            guard let url = createURL() else {
                completion(.failure(NetworkingError.badUrl))
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    if let error {
                        completion(.failure(error))
                    }
                    return
                }
                do {
                    let coordinate = try JSONDecoder().decode(Items.self, from: data)
                    completion(.success(coordinate))
                } catch {
                    completion(.failure(NetworkingError.invalidData))
                }

            }.resume()
    }
    
    enum NetworkingError: Error {
        case badUrl, badRequest, badResponse, invalidData
    }
    
}
