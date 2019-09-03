//
//  LoginResponse.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 8/30/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation

struct LoginResponse: Codable{
    let account: [AccountResponse]
    let session: [SessionResponse]
}
