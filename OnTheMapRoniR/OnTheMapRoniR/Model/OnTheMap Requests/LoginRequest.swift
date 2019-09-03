//
//  LoginRequest.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 8/28/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation
// udacity - (Dictionary) a dictionary containing a username/password pair used for authentication
// username - (String) the username (email) for a Udacity student
// password - (String) the password for a Udacity student

struct LoginRequest: Codable{
    let udacity:[String:String]
    let username: String
    let password: String
    
}
