//
//  OnTheMapClient.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 8/7/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation
import CoreLocation

class OnTheMapClient
{
    
    struct Auth
    {
        static var sessionId = ""
        static var userKey = ""
        static var firstName = ""
        static var lastName = ""
    }
    
    struct LocationDetail {
        static var longitudeVal: CLLocationDegrees = 0.0
        static var latitudeVal: CLLocationDegrees = 0.0
    }
    
    enum Endpoints
    {
        static let postStudentLocationUrl = "https://onthemap-api.udacity.com/v1/StudentLocation"
        static let udacitySignUpPage = "https://auth.udacity.com/sign-up"
        static let getSessionIdBase = "https://onthemap-api.udacity.com/v1/session"
        static let getUserInfo = "https://onthemap-api.udacity.com/v1/users/"
        static let base = "https://onthemap-api.udacity.com/v1/"
        //https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt
        
        
        
        case getUdacitySignUpPage
        case getSessionId
        case postStudentLocation
        case getStudentLocationMax(String)
        case getPublicUserData(String)
        
        
        var stringValue: String
        {
            switch self
            {
                case .getUdacitySignUpPage: return Endpoints.udacitySignUpPage
                case .getSessionId: return Endpoints.getSessionIdBase
                case .getStudentLocationMax(let maxUsers): return Endpoints.base + "/StudentLocation?limit=\(maxUsers)&order=-updatedAt"
                case .getPublicUserData(let userId): return Endpoints.getUserInfo + userId
                case .postStudentLocation: return Endpoints.postStudentLocationUrl
            }
        }
        
        var url: URL
        {
            return URL(string: stringValue)!
        }
    }
    
    /*class func postStudentInformationLocation(locationName: String, completion: @escaping (LocationCoordinatesModel?, Error?) -> Bool)
    {
        // 1. Validate location entered
        print("Session Id: \(Auth.sessionId) UserKey: \(Auth.userKey)")
    }*/
    class func validateAddressEntered(address:String,completion:@escaping  (Bool,Error?) -> Void) -> Bool
    {
        
            var isValidated = false
            let locationManager = CLGeocoder()
            locationManager.geocodeAddressString(address, completionHandler: {
                (placemarks: [CLPlacemark]?, error: Error?) -> Void in
                if let placemark = placemarks?[0]{
                    self.LocationDetail.latitudeVal = placemark.location!.coordinate.latitude
                    self.LocationDetail.longitudeVal = placemark.location!.coordinate.longitude
                    completion(true, error)
                    isValidated = true
                }
                else{
                    completion(false,error)
                    
                }
            } )
        
        return isValidated
           }
    class func postStudentInformationLocation(mapStringLocation:String,mediaUrlStr:String, completion:@escaping (Bool, Error?) -> Void)
    {
        
        // 1.  Set Body
        
        print("Session Id: \(Auth.sessionId) UserKey: \(Auth.userKey) First Name: \(Auth.firstName)  Last Name: \(Auth.lastName)")
        let requestBody = PostingStudentLocationRequest(uniqueKey: Auth.sessionId, firstName: Auth.firstName, lastName: Auth.lastName, mapString:mapStringLocation , mediaURL: mediaUrlStr, latitude: self.LocationDetail.latitudeVal, longitude: self.LocationDetail.longitudeVal)
        
        taskForPOSTRequest(extraCharFlag:false, acceptIncludeFlag:false ,contentTypeIncludeFlag: true, url: Endpoints.postStudentLocation.url, responseType: PostingStudentLocationResponse.self, body: requestBody) {(response,error) in
            if let response = response
            {
                if response.objectId != ""
                {
                    DispatchQueue.main.async
                    {
                        completion(true,nil)
                    }
                    
                }
                else
                {
                    completion(false,error)
                }
                    
            }
            
            else
            {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                
            }
            
        }
       
        
       
    }
    
    class func getStudentInformation(numberOfStudentsToRetrieve:String,completion: @escaping ([StudentInformation]?, Error?) -> Void){
        
        taskForGETRequest(extraCharFlag: false, url: Endpoints.getStudentLocationMax(numberOfStudentsToRetrieve).url, responseType: StudentInformationResults.self){
            (response,error) in
            if let response = response
            {
                DispatchQueue.main.async
                {
                    completion(response.results, nil)
                }
            }
            else
            {
                DispatchQueue.main.async
                {
                    completion([], error)
                }
            }
        }
    }
    
    class func getUserInfo(userKey: String, completion: @escaping( Bool, Error?) -> Void)
    {
        
        print("END POINT CHECK \(Endpoints.getPublicUserData(Auth.userKey).stringValue)")
        taskForGETRequest(extraCharFlag: true, url: Endpoints.getPublicUserData(Auth.userKey).url
               , responseType: PublicUserDataGenResponse.self){
                   (response,error) in
                   if let response = response
                   {
                       DispatchQueue.main.async
                       {
                        Auth.firstName = response.firstName
                        Auth.lastName = response.lastName
                           completion(true, nil)
                       }
                   }
                   else
                   {
                       DispatchQueue.main.async
                       {
                           completion(false, error)
                       }
                   }
               }    }
    
   
    class func getSessionId(userName:String, password:String, completion:@escaping (Bool, Error?) -> Void)
    {
        // 1. Set Body
        let loginCreds = LoginCredentials(username: userName, password: password)
        let loginRequest = LoginRequest(udacity: loginCreds)
        
        taskForPOSTRequest(extraCharFlag:true, acceptIncludeFlag:true,contentTypeIncludeFlag:true, url: Endpoints.getSessionId.url, responseType: LoginResponse.self, body: loginRequest){(response,error) in
            if let response = response
            {
                if response.session.id != ""
                {
                    DispatchQueue.main.async
                    {
                        // Set the sessionId & userKey
                        Auth.sessionId = response.session.id
                        Auth.userKey = response.account.key
                        completion(true,nil)
                    }
                    
                }
                else
                {
                    completion(false,error)
                }
                    
            }
            
            else
            {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                
            }
            
        }
    }
    
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(extraCharFlag: Bool,url:URL, responseType: ResponseType.Type,completion: @escaping(ResponseType?,Error?)->Void) -> URLSessionTask{
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
          
            
            
            let decoder = JSONDecoder()
            do {
                if extraCharFlag{
                    // Per Udacity API, need to skip the first 5 characters as this is junk data
                              let range = 5 ..< data.count
                              let newData = data.subdata(in: range)
                              data = newData
                }
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
                
            } catch let error {
                
                /*if let decodingError = error as? DecodingError{
                    print("ERROR converting: \(decodingError.errorDescription.debugDescription)  ERROR REASON: \(decodingError.failureReason.debugDescription) LOCALIZED DESCRIPTION: \(decodingError.localizedDescription)")
                }*/
                do{
                    // Per Udacity API, need to skip the first 5 characters as this is junk data
                    let range = 5 ..< data.count
                    let newErrorData = data.subdata(in: range)
                    
                    let errorResponse = try decoder.decode(OTMResponse.self, from: newErrorData)
                    DispatchQueue.main.async {
                        completion(nil,errorResponse)
                    }
                }
                catch{
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    
                }
                
            }
        }
        task.resume()
        return task
        
    }
    
    @discardableResult class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(extraCharFlag: Bool,acceptIncludeFlag:Bool, contentTypeIncludeFlag:Bool, url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask{
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if acceptIncludeFlag == true {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        if contentTypeIncludeFlag == true{
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpBody = try!JSONEncoder().encode(body)
        print(request.url?.absoluteString)
        print("DEBUG POST: \(request.httpBody?.description)")
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            guard var data = data else{
                completion(nil,error)
                return
            }
            // Per Udacity API, need to skip the first 5 characters as this is junk data
            //let range = 5 ..< data.count
            //let newData = data.subdata(in: range)
            
            
            let decoder = JSONDecoder()
            do
            {
                if extraCharFlag{
                    // Per Udacity API, need to skip the first 5 characters as this is junk data
                              let range = 5 ..< data.count
                              let newData = data.subdata(in: range)
                              data = newData
                }
                
                let responseObject = try decoder.decode(responseType.self,from:data)
                completion(responseObject,nil)
            }
            catch
            {
                do
                {
                    // Per Udacity API, need to skip the first 5 characters as this is junk data
                    let range = 5 ..< data.count
                    let newErrorData = data.subdata(in: range)
                    
                    let errorResponse = try decoder.decode(OTMResponse.self, from: newErrorData)
                    DispatchQueue.main.async {
                        completion(nil,errorResponse)
                    }
                    
                }
                catch{
                    DispatchQueue.main.async{
                        completion(nil,error)
                    }
                }}
        }
        task.resume()
        return task
    }
    
    
}
