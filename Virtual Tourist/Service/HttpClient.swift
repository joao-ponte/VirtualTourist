//
//  HttpClient.swift
//  Virtual Tourist
//
//  Created by João Ponte on 25/07/2023.
//

import Foundation

class HttpClient {
    
    func taskForGetRequest<ResponseType: Decodable>(url: URL,
                                                    response: ResponseType.Type,
                                                    completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                    print(responseObject)
                }
            } catch {
                completion(nil, error)
                print(error)
            }
        }
        task.resume()
    }
    
}
