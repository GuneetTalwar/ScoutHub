//
//  Profile.swift
//  ScoutHub
//
//  Created by guneet talwar on 13/11/23.
//

import Foundation
import SwiftData

struct UserProfile: Hashable,Codable {
    let login: String
    let name: String
    let avatar_url: String
    let bio: String
    
}
