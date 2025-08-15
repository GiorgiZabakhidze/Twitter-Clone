//
//  RequestServices.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 26/8/23.
//

import Foundation

public class RequestServices {
    public static var requestDomain = ""
    
    public static func postTweet(text: String, user: String, username: String, userId: String, completion: @escaping (_ result: [String : Any]?) -> Void) {
        
        let params = ["text": text, "user": user, "username": username, "userId": userId] as [String : Any]
        
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }catch let error {
            print(error)
        }
        
        //Authetication Part in the HTTP request
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    completion(json)
                }
            }catch let error {
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    static func fetchTweets(completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: requestDomain)!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                completion(.success(data))
            }
            
            task.resume()
        }
    }
    
    public static func followingProcess(id: String, completion: @escaping (_ result: [String : Any]?) -> Void) {
        
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            
            guard let data = data else { return }
            
            do {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    completion(json)
                }
            }catch let error {
                print(error)
                print("dfv")
            }
        }
        
        task.resume()
        
    }
    
    public static func likeProcess(id: String, completion: @escaping (_ result: [String : Any]?) -> Void) {
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            
            guard let data = data else { return }
            
            do {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    completion(json)
                }
            }catch let error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    public static func sendNotification(username: String, notSenderId: String, notReceiverId: String, notificationType: String, postText: String, postLikes: Array<String>, completion: @escaping (_ result: [String : Any]?) -> Void) {
        
        var params: [String : Any] {
            postText.isEmpty
            ?
                ["username": username, "notSenderId": notSenderId, "notReceiverId": notReceiverId, "notificationType": notificationType] as [String : Any]
            :
            ["username": username, "notSenderId": notSenderId, "notReceiverId": notReceiverId, "notificationType": notificationType, "postText": postText, "postLikes": postLikes] as [String : Any]
        }
        
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }catch let error {
            print(error)
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    completion(json)
                }
            }catch let error {
                print(error)
                print("bruhha")
            }
            
        }
        
        task.resume()
        
    }
    
    static func FetchUserNotifications(userId: String, completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        let url = URL(string: "http://192.168.100.114:3000/notifications/\(userId)")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"

        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!

        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else { return }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    static func SendMessages(name: String, username: String, mesSenderId: String, mesReceiverId: String, message: String, completion: @escaping (_ result: [String : Any]?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            var params: [String : Any] {
                ["name": name, "username": username, "mesSenderId": mesSenderId, "mesReceiverId": mesReceiverId, "message": message] as [String : Any]
            }
            
            let url = URL(string: requestDomain)!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            }catch let error {
                print(error.localizedDescription)
            }
            
            let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request) { data, res, err in
                guard err == nil else { return }
                
                guard let data = data else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                        completion(json)
                    }
                }catch let error {
                    print(error.localizedDescription)
                    print("Message Was Not Succesfully Sent")
                }
            }
            
            task.resume()
            
        }
    }
    
    static func FetchUserMessages(userId: String, completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        let url = URL(string: "http://192.168.100.114:3000/messages/\(userId)")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Conten-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
}
