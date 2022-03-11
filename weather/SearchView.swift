//
//  SearchView.swift
//  weather
//
//  Created by Hatice on 18.02.2022.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @State private var searchString = ""
    @StateObject fileprivate var viewModel = CitiesModel()
    
    var body: some View {
        NavigationView{
            List(viewModel.cities, id: \.self) { city in
                NavigationLink(destination: WeatherRow(name: city.name, weatherAPIClient: WeatherAPIClient(userLatitude: Double(city.latitude) ?? 0, userLongitude: Double(city.longitude) ?? 0))){
                        Text(city.name)
                }.navigationTitle("Weather")
            }
        }.searchable(text: $viewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .always))
    }    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
