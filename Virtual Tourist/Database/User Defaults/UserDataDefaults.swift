//
//  UserDataDefaults.swift
//  Virtual Tourist
//
//  Created by João Ponte on 14/08/2023.
//

import Foundation

protocol UserDefaultsProtocol {
    func write<T>(_ value: T, forKey key: String)
    func readDouble(forKey key: String) -> Double
    func readBool(forKey key: String) -> Bool
}
