//
//  NetWork.swift
//  JuntoTest
//
//  Created by Mikhail Koroteev on 12.07.17.
//  Copyright © 2017 Mikhail Koroteev. All rights reserved.
//

import Foundation
import Alamofire

class NetWork: NSObject {
    
    func getFromProductHunt(urlString: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer 591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
            "Accept": "application/json",
            "Host" : "api.producthunt.com",
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            debugPrint(response)
        }
    }
    
}
