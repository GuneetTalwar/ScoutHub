//
//  ListItemView.swift
//  iOS-app-challenge
//
//  Created by Guneet Talwar on 10/11/23.
//

import SwiftUI

struct ProfileRowView: View {
    @State var profile : Profile
    @Environment(\.managedObjectContext) var moc
    @State var favouriteStar = "star"

    
    var body: some View {
        VStack(alignment: .leading)
        {
            HStack
            {
                AsyncImage(url: URL(string: profile.image_url!)){image in image
                        .image?.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                }
                
                VStack(alignment: .leading)
                {
                    Text(profile.name!)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Text(profile.username!)
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                }
                Spacer()
                Button{
                    profile.is_favourite.toggle()
                    setFavouriteButtonLabel()
                    try? moc.save()
                    
                }
            label: {
                Image(systemName: favouriteStar)
            }

                
                
            }.padding() // Provides some buffer around the product
                .background(Color.white)
                .contentShape(Rectangle()) // For tapping
                .cornerRadius(5.0)// Rounding!
            
            HStack{
                Text(profile.bio!)
                    .font(.system(size: 10, design: .default))
                    .padding(.leading)
            }
        }.onAppear{
            setFavouriteButtonLabel()
        }
    }
    
    private func setFavouriteButtonLabel()
    {
        if profile.is_favourite{
            self.favouriteStar = "star.fill"
        }
        else{
            self.favouriteStar = "star"
        }
        
    }
}
//struct ListItemView: View {
//
//    let profile: Profile
//    var body: some View
//    {
//        HStack(alignment: .center) {
//            AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/21276601?s=200&v=4")){image in image
//                    .image?.resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100, height: 100)
//            }.padding(.trailing)
//            VStack(alignment: .leading) {
//                Text(profile.fullName)
//                    .font(.system(size: 26, weight: .bold, design: .default))
//                    .foregroundColor(.white)
//                Text(type)
//                    .font(.system(size: 16, weight: .bold, design: .default))
//                    .foregroundColor(.gray)
//                HStack {
//                    Text("$" + String.init(format: "%0.2f", profile.userName))
//                        .font(.system(size: 16, weight: .bold, design: .default))
//                        .foregroundColor(.white)
//                        .padding(.top, 8)
//                }
//            }.padding(.trailing, 20)
//            Spacer()
//        }
//        .frame(maxWidth: .infinity, alignment: .center)
//        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
//        .modifier(CardModifier())
//        .padding(.all, 10)
//    }
//
//}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }

}



//#Preview {
//    ProfileRowView(profile: ProfileModel(username: "username", name: "Full Name", image_url: "https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg", bio: "String"))
//}
