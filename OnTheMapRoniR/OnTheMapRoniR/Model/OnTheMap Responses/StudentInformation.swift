//
//  StudentInformationResponse.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 9/16/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation

struct StudentInformation: Codable{
    let firstName:String
    let lastName:String
    let longitude:Float
    let latitude:Float
    let mapString:String
    let mediaURL:String
    let uniqueKey:String
    let objectId:String
    let updatedAt:String
    let createdAt:String
}
