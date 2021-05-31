//
//  CryptoAPIService.swift
//  CryptoTracker
//
//  Created by Shaikat on 31/5/21.
//  Copyright © 2021 Shayla.18. All rights reserved.
//

import Foundation

final class CryptoAPIService {
    static let shared = CryptoAPIService()
    public var icons : [Icon] = []
    
    private init (){}
    
    private struct APIInfo {
        static let apiKey = "09139589-D191-4F46-BA2C-A090F7E6E768"
        static let host = "https://rest.coinapi.io/"
        static let path = "v1/assets/"
        static let getAllIcon = "icons/48/"
    }
    
   // private var onReadyAfterIconIsReady :(( Result <[CryptoModel], Error>)-> Void)?
    public func getAllAssets(completion : @escaping ( Result <[CryptoModel], Error>)-> Void) {
        if let url = URL(string: APIInfo.host + APIInfo.path + "?apikey=" + APIInfo.apiKey) {
            //urlsession request the upload or download request
            let urlsession = URLSession.shared
            //dataTask performs the task based om request
            let dataTask = urlsession.dataTask(with: url) { (data, response, error) in
                if let myData = data {
                    do {
                        
                        let cryptoArray = try JSONDecoder().decode([CryptoModel].self, from: myData)
                        completion(.success(cryptoArray.sorted(by: { (first, second) -> Bool in
                            return first.price_usd ?? 0.0 > second.price_usd ?? 0.0
                        })))
                    } catch  {
                        completion(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    public func getAllIcons() {
        if let url = URL(string: APIInfo.host + APIInfo.path + APIInfo.getAllIcon + "?apikey=" + APIInfo.apiKey) {
            let urlsession = URLSession.shared
            let dataTask = urlsession.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        self.icons = try JSONDecoder().decode([Icon].self, from: data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
            
        }
    }
}
