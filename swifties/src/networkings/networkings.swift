//
//  networkings.swift
//  swifties
//
//  Created by aldinugroho on 04/12/22.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodingError
}

class networkings {
    func fetchdataswifties(completion: @escaping (Result<swiftiesdatamodel,NetworkError>) -> Void) {
        let urlMain = URL(string: "https://taylorswiftapi.onrender.com/get")!
        let session = URLSession.shared
        session.dataTask(with: urlMain) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                do {
                    print(String(data: data, encoding: .utf8) as AnyObject)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(swiftiesdatamodel.self, from: data)
                    completion(.success(result))
                } catch (let e) {
                    print(e)
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
