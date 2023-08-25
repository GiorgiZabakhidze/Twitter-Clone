//
//  AuthServices.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 23/8/23.
//

import SwiftUI
import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

public class AuthServices {
    
    public static var requestDomain = ""
    
    static func login(email: String, password: String, completion: @escaping (_ result: Result<Data, AuthenticationError>) -> Void) {
        
        let urlString = URL(string: "http://localhost:3000/users/login")!
        
        makeRequest(urlString: urlString, reqBody: ["email": email, "password": password]) { result in
            switch result {
                case .success(let data):
                    completion(.success(data!))
                case .failure(_):
                    completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func register(name: String, username: String, email: String, password: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        
        let urlString = URL(string: "http://localhost:3000/users")!
        
        makeRequest(urlString: urlString, reqBody: ["name": name, "username": username, "email": email, "password": password]) { result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func makeRequest(urlString: URL, reqBody: [String : Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }catch let err {
            print(err)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                     
                }
                    
            }catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    //Fetch User
    static func fetchUser(id: String, completion: @escaping (_ result: Result<Data, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3000/users/\(id)")!
        
        var request = URLRequest(url: urlString)
        
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                return
            }
            
            guard let data = data else {
                return completion(.failure(.invalidCredentials))
            }
            
            completion(.success(data))
            
            do {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    
                }
                
            }catch let err {
                completion(.failure(.invalidCredentials))
                print(err)
            }
        }
        
        task.resume()
    }
    
}
