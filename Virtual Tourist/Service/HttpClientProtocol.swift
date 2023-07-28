//
//  HttpClientProtocol.swift
//  Virtual Tourist
//
//  Created by João Ponte on 28/07/2023.
//

import Foundation

protocol HttpClientProtocol {
    
    func taskForGetRequest<ResponseType: Decodable>(url: URL,
                                                    response: ResponseType.Type,
                                                    completion: @escaping (ResponseType?, Error?) -> Void)
}
