//
//  AppConstants.swift
//  ios_party
//
//  Created by Юлия Воротченко on 19.11.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import Foundation

struct AppURL {
    static let getToken = "http://playground.tesonet.lt/v1/tokens"
    static let getServers = "http://playground.tesonet.lt/v1/servers"
}

struct Key {
    static let username = "username"
    static let password = "password"
}

struct  Headers {
    static let contentType = "Content-type"
    static let value = "application/json"
    static let authorization = "Authorization"
    static let bearer = "Bearer \(UserDefaultsContainer.sessionToken)"
}

struct Constants {
    static let cell = "Cell"
    static let byDistance = "By Distance"
    static let alphanumerical = "Alphanumerical"
    static let cancel = "Cancel"
    static let km = "km"
}



