//
//  OnTheMapClient.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 8/7/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation

class OnTheMapClient
{
    
    struct Auth
    {
        static var sessionId = ""
    }
    
    enum Endpoints
    {
        static let udacitySignUpPage = "https://auth.udacity.com/sign-up"
        static let getSessionIdBase = "https://onthemap-api.udacity.com/v1/session"
        static let base = "https://onthemap-api.udacity.com/v1/"
        //https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt
        
        
        
        case getUdacitySignUpPage
        case getSessionId
        case getStudentLocationMax(String)
        
        
        var stringValue: String
        {
            switch self
            {
                case .getUdacitySignUpPage: return Endpoints.udacitySignUpPage
                case .getSessionId: return Endpoints.getSessionIdBase
                case .getStudentLocationMax(let maxUsers): return Endpoints.base + "/StudentLocation?limit=\(maxUsers)?order=-updatedAt"
            }
        }
        
        var url: URL
        {
            return URL(string: stringValue)!
        }
    }
    class func getStudentInformation(numberOfStudentsToRetrieve:String,completion: @escaping ([StudentInformation], Error?) -> Void){
        
        taskForGETRequest(url: Endpoints.getStudentLocationMax(numberOfStudentsToRetrieve).url, responseType: StudentInformationResults.self){
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
    class func getSessionId(userName:String, password:String, completion:@escaping (Bool, Error?) -> Void)
    {
        // 1. Set Body
        let loginCreds = LoginCredentials(username: userName, password: password)
        let loginRequest = LoginRequest(udacity: loginCreds)
        
        taskForPOSTRequest(url: Endpoints.getSessionId.url, responseType: LoginResponse.self, body: loginRequest){(response,error) in
            if let response = response
            {
                if response.session.id != ""
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
    
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url:URL, responseType: ResponseType.Type,completion: @escaping(ResponseType?,Error?)->Void) -> URLSessionTask{
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            // Per Udacity API, need to skip the first 5 characters as this is junk data
            //let range = 5 ..< data.count
            //let newData = data.subdata(in: range)
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
                
            } catch {
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
    
     @discardableResult class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask{
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try!JSONEncoder().encode(body)
        print(request.url!)
        print(request.httpBody.self!)
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            guard let data = data else{
                completion(nil,error)
                return
            }
            // Per Udacity API, need to skip the first 5 characters as this is junk data
            let range = 5 ..< data.count
            let newData = data.subdata(in: range)
            
            
            let decoder = JSONDecoder()
            do
            {
                
                let responseObject = try decoder.decode(responseType.self,from:newData)
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
