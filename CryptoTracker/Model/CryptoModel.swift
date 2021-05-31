//
//  CryptoModel.swift
//  CryptoTracker
//
//  Created by Shaikat on 29/5/21.
//  Copyright © 2021 Shayla.18. All rights reserved.
//

import UIKit
 
struct CryptoModel: Codable {
    let asset_id : String
    let name : String?
    let price_usd : CGFloat?
    let id_icon : String?
}

struct  Icon : Codable{
    let asset_id : String
    let url : String
}
