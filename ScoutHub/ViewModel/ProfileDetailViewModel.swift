//
//  ProfileDetailViewModel.swift
//  ScoutHub
//
//  Created by guneet talwar on 11/11/23.
//

import Foundation
import SwiftUI

extension ProfileDetailView{
    
    class ProfileDetailViewModel: ObservableObject {
        @Published var username: String = "GuneetTalwar"
        @Published var repositories: [Repository] = []
        func getRepositoriesRequest(username: String)
        {
            guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {return }
            
            let task = URLSession.shared.dataTask(with: url){ data, _,error in
                guard let data = data, error == nil else {return}
                
                
                
                do{
                    let repositories = try JSONDecoder().decode([Repository].self, from: data)
                }
                catch{
                    print(error)
                }
            }
            task.resume()
            
        }
        func fetch()
        {
            self.getRepositoriesRequest(username: username)
        }
        //private let repositories = ["A","B","C","D","E","A"]
        init() {
            
        }
    }

}

