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
        
        case getUdacitySignUpPage
        case getSessionId
        
        
        var stringValue: String
        {
            switch self
            {
                case .getUdacitySignUpPage: return Endpoints.udacitySignUpPage
                case .getSessionId: return Endpoints.getSessionIdBase
            }
        }
        
        var url: URL
        {
            return URL(string: stringValue)!
        }
    }
    
    class func getSessionId(userName:String, password:String, completion:@escaping (Bool, Error?) -> Void)
    {
        // 1. Set Body
        let body = LoginRequest(udacity: [userName:password],username: userName, password: password)
        
        taskForPOSTRequest(url: Endpoints.getSessionId.url, responseType: LoginResponse.self, body: body){(response,error) in
            if let response = response{
                DispatchQueue.main.async {
                    completion(true,nil)
                }
            }
            else{
                DispatchQueue.main.async {
                    completion(false, error)
                }
                
            }
            
        }
    }
    
    @discardableResult class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask{
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try!JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            guard let data = data else{
                completion(nil,error)
                return
            }
            let decoder = JSONDecoder()
            do {
                
                let responseObject = try decoder.decode(responseType.self,from:data)
                completion(responseObject,nil)
            }
            catch
            {
                do
                {
                    let errorResponse = try decoder.decode(OTMResponse.self, from: data)
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
