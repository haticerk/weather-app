//
//  CityModel.swift
//  weather
//
//  Created by Hatice on 21.02.2022.
//

import Foundation
import Combine
import SwiftUI

struct City: Identifiable, Hashable, Decodable{
    enum CodingKeys: CodingKey{
        case id
        case name
        case latitude
        case longitude
        case population
        case region
    }
    var idk = UUID()
    var id: Int
    var name: String
    var latitude: String
    var longitude: String
    var population: Int
    var region: String
}

class ReadData: ObservableObject {
    static let shared: ReadData = ReadData()
    @Published var cities = [City]()
    
    init(){
        loadData()
    }
    
    func loadData(){
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json")
        else{
            print("JSON file cannot found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let cities = try? JSONDecoder().decode([City].self, from: data!)
        self.cities = cities!
    }
}

class CitiesModel: ObservableObject {
    @Published var originalCities = ReadData.shared.cities
    @Published var cities = [City]()
    @Published var searchTerm: String = ""
    
    init() {
        Publishers.CombineLatest($originalCities, $searchTerm)
            .map {cities, searchTerm in cities
            .filter { city in searchTerm.isEmpty ? true : (city.name.contains(searchTerm))
            }
            }
            .assign(to: &$cities)
    }
}
