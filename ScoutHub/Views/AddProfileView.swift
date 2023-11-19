//
//  AddProfileView.swift
//  ScoutHub
//
//  Created by guneet talwar on 11/11/23.
//

import SwiftUI

struct AddProfileView: View {
    @StateObject var viewModel = AddProfileViewModel()
    @Binding var newItemPresented: Bool
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    var body: some View {

            Text("Add New Profile")
                .font(.system(size: 32))
                .bold()
            
            Form
            {
                TextField("Type GitHub Username", text: $viewModel.username)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                Button("Search")
                {
                    viewModel.fetch()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
                
            if let user = viewModel.user
            {
                VStack{
                    AsyncImage(url: URL(string: viewModel.user!.avatar_url)){image in image
                            .image?.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                    }.padding()
                    
                   
                    Text(viewModel.user!.name)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Text(viewModel.user!.login)
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    Text(viewModel.user!.bio)
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    
                    Button("Add")
                    {
                        let profile = Profile(context: moc)
                        profile.name = user.name
                        profile.bio = user.bio
                        profile.image_url = user.avatar_url
                        profile.username = user.login
                        try? moc.save()
                        dismiss()
                        
                    }
                        .buttonStyle(.bordered)
                }
            }
            
            Button("Dismiss",action: { newItemPresented = false })
            Spacer()

        
        
    }
}


#Preview {
    AddProfileView(newItemPresented: Binding(get: {return true}, set: {_ in}))
}
