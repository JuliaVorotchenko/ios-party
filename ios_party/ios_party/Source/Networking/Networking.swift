//
//  Networking.swift
//  ios_party
//
//  Created by Юлия Воротченко on 01.12.2019.
//  Copyright © 2019 Юлия Воротченко. All rights reserved.
//

import UIKit
import Alamofire

class Networking {
    enum HeadersType {
        case authorization
        case contentType
    }
    
    let url = URL(string: AppURL.tokenUrl)!
    let encoder =  JSONParameterEncoder.default
    
    
    func getToken<T: Encodable>(model: T, header: HeadersType = .authorization, completion: ((Result<TokenModel, AFError>) -> ())?) {
        AF.request(self.url, method: .post, parameters: model, encoder: self.encoder, headers: self.setHeader(of: header))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: TokenModel.self) { response in
                completion?(response.result)
                
        }
    }
    
    private func setHeader(of type: HeadersType) -> HTTPHeaders {
        switch type {
        case .authorization:
            return [Headers.contentType: Headers.value]
        case .contentType:
            return [Headers.contentType: Headers.value]
        }
        
    }
    
    
}
