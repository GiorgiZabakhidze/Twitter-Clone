//
//  FeedViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 29/8/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        
        RequestServices.fetchTweets { res in
            DispatchQueue.global(qos: .background).async {
                switch res {
                    case .success(let data):
                        guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else { return }
                        DispatchQueue.main.async {
                            self.tweets = tweets
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}
