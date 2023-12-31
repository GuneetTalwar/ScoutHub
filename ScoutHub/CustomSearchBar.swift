//
//  CustomSearchBar.swift
//  ScoutHub
//
//  Created by guneet talwar on 16/11/23.
//

import Foundation

import Foundation 
import SwiftUI

struct CustomSearchBar: UIViewRepresentable
{
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        }
    
    func makeCoordinator() -> Coordinator{
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate{
        
        @Binding private var text: String
        
        init(text: Binding<String>){
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
    }
}
