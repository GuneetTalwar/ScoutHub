//
//  AddProfileViewModel.swift
//  ScoutHub
//
//  Created by guneet talwar on 11/11/23.
//

import Foundation
//import SwiftData
import SwiftUI


class AddProfileViewModel: ObservableObject {
    @Published var username = "GuneetTalwar"
    @Published var user: UserProfile?
    @Environment(\.managedObjectContext) var moc
    
    internal func getProfileRequest(username: String)
    {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {return}
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _,error in
                guard let data = data, error == nil else {return}
            
            
            do{
                let user = try JSONDecoder().decode(UserProfile.self, from: data)
                DispatchQueue.main.async {
                    self?.user = user
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func fetch()
    {
        getProfileRequest(username: username)
    }
    init(){
        
    }
//    func save()
//    {
//        let profile = Profile(context: moc)
//        profile.name = user?.name
//        profile.bio = user?.bio
//        profile.image_url = user?.avatar_url
//        profile.username = user?.login
//        try? moc.save()
//    }
}
