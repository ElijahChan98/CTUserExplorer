//
//  RequestManager.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//
import UIKit

public enum RequestMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
}

class RequestManager {
    static let shared = RequestManager()
    
    public func fetchUsers(since: Int, limit: Int, completion: @escaping (_ success: Bool, _ response: [String:Any]?) -> ()) {
        let queryItems = [URLQueryItem(name: "start", value: "\(since)"),
                          URLQueryItem(name: "limit", value: "\(limit)"),
        ]
        var urlComponents = URLComponents(string: Constants.USERS_BASE_URL)!
        urlComponents.queryItems = queryItems
        self.createGenericRequest(url: urlComponents.url!, requestMethod: .get) { (success, response) in
            completion(success, response)
        }
    }
    
    /// Generic Request Handler. Will return a success boolean and a response which can change values depending on the payload returned by the API
    private func createGenericRequest(url: URL, requestMethod: RequestMethod, completion: @escaping (_ success: Bool, _ response: [String: Any]?) -> ()) {
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 401 {
                    }
                    else if httpResponse.statusCode == 500 {
                        //internal server error
                    }
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let payload = json as? [String: Any] {
                            completion(true, payload)
                        }
                        else if let payloads = json as? [[String:Any]] {
                            //print(payloads)
                            completion(true, ["payloads" : payloads])
                        }
                    }
                    catch {
                        print("something went wrong")
                    }
                }
                else {
                    completion(false, nil)
                }
            }
        }
        task.resume()
    }

}
