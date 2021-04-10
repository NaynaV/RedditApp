//
//  PostModel.swift
//  RedditApp
//
//  Created by Nayna on 4/7/21.

import Foundation

class PostModel {
    var title: String?
    var likes: Int?
    var image: String?
    var num_comments: Int?
    var description: String?
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String
        self.likes = dictionary["likes"] as? Int ?? 0
        
        let preview = (dictionary["preview"] as? [String: Any] ?? [:])["images"] as? [[String:Any]] ?? []
        if preview.count > 0 {
            self.image =  (preview[0]["source"] as? [String:Any] ?? [:])["url"] as? String ?? ""
            
            self.image = self.image?.replacingOccurrences(of: "amp;", with: "")
        }
        
        let desc = (dictionary["all_awardings"] as? [[String: Any]] ?? [])
        if desc.count > 0 {
            self.description =  desc[0]["description"] as? String ?? ""
        }
        
        self.num_comments = dictionary["num_comments"] as? Int ?? 0
    }
    
    class func getInstance(dictionary: [String: Any]) -> PostModel? {
        let response = PostModel(dictionary: dictionary)
        return response
    }
    
    class func getList(array: [[String: Any]]) -> [PostModel]? {
        var list: [PostModel] = []
        for obj in array {
            if let instance = PostModel.getInstance(dictionary: obj["data"] as! [String: Any]) {
                list.append(instance)
            }
        }
        return list.count == 0 ? nil : list
    }
}
