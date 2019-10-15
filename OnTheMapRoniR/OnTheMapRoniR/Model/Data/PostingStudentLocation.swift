//
//  PostingStudentLocation.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 9/30/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation

struct PostingStudentLocation: Codable {
    // 1. "uniqueKey: \"1234\",
    let uniqueKey:String
    
    // 2. \"firstName\": \"John\",
    let firstName:String
    
    // 3. \"lastName\": \"Doe\",
    let lastName:String
    
    // 4. \"mapString\": \"Mountain View, CA\",
    let mapString:String
    
    // 5. \"mediaURL\": \"https://udacity.com\",
    let mediaURL:String
    
    // 6. \"latitude\": 37.386052,
    let latitude:Double
    
    // 7. \"longitude\": -122.083851}"
    let longitude:Double
}
