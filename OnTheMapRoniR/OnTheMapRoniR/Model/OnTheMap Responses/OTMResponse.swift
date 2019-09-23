//
//  OTMResponse.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 8/22/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation

struct OTMResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case statusMessage = "error"
    }
    
    
}

extension OTMResponse: LocalizedError{
    var errorDescription: String?{
        return statusMessage
    }
}
