//
//  ScoutHubApp.swift
//  ScoutHub
//
//  Created by guneet talwar on 11/11/23.
//

import SwiftUI
import SwiftData

@main
struct ScoutHubApp: App {
    @StateObject private var dataController = DataController()
    init()
    {
        
    }
    var body: some Scene {
        WindowGroup {
            ProfileListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        
    }
}
