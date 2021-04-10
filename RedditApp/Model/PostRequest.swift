//
//  PostRequest.swift
//  RedditApp
//
//  Created by Nayna on 4/7/21.


import UIKit

class PostRequest {

    // MARK : API Call 
    class func getDataApiCall(callback: ((_ data: [PostModel])->Void)?) {
        let url: URL! = URL(string: "https://www.reddit.com/.json")!
        let method = "GET"
        var request = URLRequest(url: url!)
        request.httpMethod = method
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 60
        
        let session = URLSession(configuration: config)
        print("Start: \(Date()), \(url.absoluteString)")
        let task = session.dataTask(with: request, completionHandler: { (dataObj: Data?, response: URLResponse?, error: Error?) in
            print("End: \(Date()), \(url.absoluteString)")
            DispatchQueue.main.async(execute: {
                if(error == nil){
                    if let d = try? JSONSerialization.jsonObject(with: dataObj!, options: []) {
                        if let response = d as? [String : Any] {
                            print(response)
                            let postData = PostModel.getList(array: (response["data"] as! [String:Any])["children"] as! [[String: Any]]) ?? []
                                callback?(postData)
                        } else {
                            print(response)
                        }
                        
                    }
                    else {
                        print(error)
                    }
                }
                else {
                    print(error)
                }
            })
        })
        task.resume()
    }
}
