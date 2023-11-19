//
//  ProfileListViewModel.swift
//  ScoutHub
//
//  Created by guneet talwar on 11/11/23.
//

import Foundation
import SwiftUI

extension ProfileListView{
    
    class ProfileListViewModel: ObservableObject {
        @Published var showingAddProfileView = false
        // @FetchRequest(sortDescriptors: []) var profiles: FetchedResults<Profile>
        // @Environment(\.managedObjectContext) var moc
        
        @Published var profileSelected: Profile?
        @Published var isProfileSelected = false
        
        @Published var username: String = "GuneetTalwar"
        @Published var repositories: [Repository] = []
        
        func getRepositoriesRequest(username: String)
        {
            guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {return }
            let sem = DispatchSemaphore(value: 0)
            let task = URLSession.shared.dataTask(with: url){ data, _,error in
                defer { sem.signal() }
                guard let data = data, error == nil else {return}
                
                
                
                do{
                    let repositories = try JSONDecoder().decode([Repository].self, from: data)
                    DispatchQueue.main.async {
                        self.repositories = repositories
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
            sem.wait(timeout: .distantFuture)
            
        }
        func fetch()
        {
            
            self.getRepositoriesRequest(username: profileSelected!.username!)
        }
//        func deleteProfile(at offsets: IndexSet) {
//            for offset in offsets {
//                // find this book in our fetch request
//                let profile = profiles[offset]
//                
//                // delete it from the context
//                moc.delete(profile)
//            }
//            
//            // save the context
//            try? moc.save()
//        }
    
        init() {
            
        }
    }

}

