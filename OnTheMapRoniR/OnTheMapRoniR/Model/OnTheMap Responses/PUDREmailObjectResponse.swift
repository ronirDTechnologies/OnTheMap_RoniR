//
//  PUDREmailObjectResponse.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 10/13/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation

struct PUDREmailObjectResponse: Codable {
    let address: String?
    let _verified: Bool?
    let _verification_code_sent:Bool?
}


