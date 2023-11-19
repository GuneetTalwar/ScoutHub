//
//  Profile.swift
//  ScoutHub
//
//  Created by guneet talwar on 13/11/23.
//

import Foundation
import SwiftData

struct Repository: Hashable,Codable {
    let id: Int
    let name: String
    let description: String?
    let topics: [String]?
    
}

//@Model
//class RepositoryModel: Identifiable {
//    @Attribute(.unique) var id: String
//    var name: String
//    var image_url: String
//    var bio: String
//    
//    init(username: String, name: String, image_url: String, bio: String) {
//        self.username = username
//        self.name = name
//        self.image_url = image_url
//        self.bio = bio
//    }
//}
