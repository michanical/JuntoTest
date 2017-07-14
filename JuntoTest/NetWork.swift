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
            completion(response.data!)
        }
    }
    
    func parseJson(data: Data) -> NSDictionary {
        let json = try? JSONSerialization.jsonObject(with: data) as! NSDictionary
        return json!
    }
    
//    func getPictureFromUrl(urlString: String) -> UIImage {
//        let pictureURL = URL(string:urlString)!
//        let session = URLSession(configuration: .default)
//        var picture = UIImage()
//       
//        let downloadPicTask = session.dataTask(with: pictureURL) { (data, response, error) in
//            if let e = error {
//                print("Error downloading picture: \(e)")
//            } else {
//                if (response as? HTTPURLResponse) != nil {
//                    if let imageData = data {
//                        let image = UIImage(data: imageData)
//                        picture = image!
//                    } else {
//                        print("Couldn't get image: Image is nil")
//                    }
//                } else {
//                    print("Couldn't get response code for some reason")
//                }
//            }
//        }
//        downloadPicTask.resume()
//
//        return picture
//    }

}
