//
//  KeychainStorage.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 25/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import Foundation
import Security

import Security

class KeyChainStorage {
    enum Identifier: String, CaseIterable {
        case appleIDEmail = "AppleIDEmail"
        case appleIDFullName = "AppleIDFullName"
        case appleIDUserIdentifier = "AppleIDUserIdentifier"
    }
    
    class func save(key: Identifier, data: Data) -> OSStatus {
        let query = [
            kSecClass as String : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key.rawValue,
            kSecValueData as String : data ] as [String : Any]
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: Identifier) -> String? {
        let query = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue,
            kSecReturnData as String : kCFBooleanTrue!,
            kSecMatchLimit as String : kSecMatchLimitOne ] as [String : Any]
        var dataTypeRef: CFTypeRef? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr, let keyData = dataTypeRef as? Data {
            return String(data: keyData, encoding: .utf8)
        } else {
            return nil
        }
        // if status == noErr {
        //     return dataTypeRef as! Data?
        // } else {
        //     return nil
        // }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {
    init<T>(from value: T) {
        self = withUnsafePointer(to: value) { (ptr: UnsafePointer<T>) -> Data in
            return Data(buffer: UnsafeBufferPointer(start: ptr, count: 1))
        }
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: type) }
    }
}
