//
//  ItemsRouter.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import Foundation
import Alamofire

enum ItemsRouter: URLRequestBuilder {
    case items
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .items:
            return "default/dynamodb-writer"
        }
    }

    // MARK: - Parameters
    internal var parameters: Parameters? {
        let params = Parameters.init()
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .items:
            return .get
        }
        
    }
}
