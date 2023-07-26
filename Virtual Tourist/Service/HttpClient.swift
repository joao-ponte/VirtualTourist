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
                completion(nil, error)
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON Data:")
                print(jsonString)
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

