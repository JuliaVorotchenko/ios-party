//
//  UserDefaultsContainer.swift
//  ios_party
//
//  Created by Юлия Воротченко on 28.10.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import Foundation

class UserDefaultsContainer {
    private enum UserDefaultsKey: String {
           case token
       }
       
       private static var defaults: UserDefaults {
           return UserDefaults.standard
       }
       
       static var sessionToken: String {
           get {
               return self.defaults.string(forKey: UserDefaultsKey.token.rawValue) ?? ""
           }
           set {
               self.defaults.set(newValue, forKey: UserDefaultsKey.token.rawValue)
               self.defaults.synchronize()
           }
       }
       
       static func registerDefaults() {
           let dictionary: [String: Any] = [UserDefaultsKey.token.rawValue: String()]
           self.defaults.register(defaults: dictionary)
       }
       
       static func unregister() {
           self.sessionToken = ""
       }

}
