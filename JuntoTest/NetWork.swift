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
    
    func getFromProductHunt(urlString: String, completion: @escaping (_ result: Data) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer 591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
            "Accept": "application/json",
            "Host" : "api.producthunt.com",
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            if response.error == nil {
                completion(response.data!)
            } else {
                print(response.error!)
            }
        }
    }
    
    func parseJson(data: Data) -> NSDictionary {
        let json = try? JSONSerialization.jsonObject(with: data) as! NSDictionary
        return json!
    }
    
    func getPictureFromUrl(urlString: String, completion: @escaping (_ result: UIImage) -> Void ) {
        let url:URL! = URL(string: urlString)
        let session = URLSession.shared
        var task = URLSessionDownloadTask()
        task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
            
            if location != nil{
                let data:Data! = try? Data(contentsOf: location!)
                do{
                    DispatchQueue.main.async(execute: { () -> Void in
                        completion(UIImage(data: data)!)
                    })
                }catch{
                    print("something went wrong, try again")
                }
            }
        })
        task.resume()
    }

}
