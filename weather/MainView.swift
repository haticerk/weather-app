//
//  MainView.swift
//  weather
//
//  Created by Hatice on 18.02.2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView{
            MapView().tabItem{
                Label("", systemImage: "map")
            }
            LocationView().tabItem{
                Label("", systemImage: "location")
            }
            SearchView().tabItem{
                Label("", systemImage: "magnifyingglass")
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
