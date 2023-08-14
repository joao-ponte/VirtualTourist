//
//  UserDefaultsProtocol.swift
//  Virtual Tourist
//
//  Created by João Ponte on 14/08/2023.
//

import Foundation

final class UserDataDefaults: UserDefaultsProtocol {
    let userDefaults = UserDefaults.standard

    func write<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func readDouble(forKey key: String) -> Double {
        userDefaults.double(forKey: key)
    }

    func readBool(forKey key: String) -> Bool {
        userDefaults.bool(forKey: key)
    }
}
