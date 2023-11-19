//
//  ContentView.swift
//  ScoutHub
//
//  Created by guneet talwar on 11/11/23.
//

import SwiftUI
import SwiftData

struct ProfileListView: View {
    
    @StateObject var viewModel = ProfileListViewModel()
    @FetchRequest(sortDescriptors: []) var profiles: FetchedResults<Profile>
    @Environment(\.managedObjectContext) var moc
    
    @State var repositories : [Repository] = [Repository(id: 1, name: "String", description: "",topics: [""])]
    @State var text: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                List{
                    ForEach(profiles){ profile in
                        
                    label:do {
                        ProfileRowView(profile: profile)
                            .onTapGesture {
                                viewModel.profileSelected = profile
                                viewModel.fetch()
                                 if !viewModel.repositories.isEmpty{
                                    viewModel.isProfileSelected = true
                                }
                            }
                            
                    }
                    }.onDelete(perform: deleteProfile)
                    
                }.buttonStyle(.borderless)

                VStack{
                    Spacer()
                    Button{
                        viewModel.showingAddProfileView.toggle()
                    }
                label: {
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }
                    
                    
                }
                .sheet(isPresented: $viewModel.showingAddProfileView )
                {
                    AddProfileView(newItemPresented: $viewModel.showingAddProfileView)
                }
            }
            .navigationTitle("Scouthub")
            .navigationDestination(isPresented: $viewModel.isProfileSelected) {
                 //profile: viewModel.profileSelected ?? Profile()
                ProfileDetailView(repositories: viewModel.repositories)
            }
        }
    }
        func deleteProfile(at offsets: IndexSet) {
            for offset in offsets {
                // find this book in our fetch request
                let profile = profiles[offset]

                // delete it from the context
                moc.delete(profile)
            }

            // save the context
            try? moc.save()
        }
    
}



//#Preview {
//    ProfileListView()
//}
