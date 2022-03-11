//
//  WeatherRow.swift
//  weather
//
//  Created by Hatice on 18.02.2022.
//

import SwiftUI
import MapKit

struct WeatherRow: View {
    var name: String
    @StateObject var weatherAPIClient: WeatherAPIClient
    
    var body: some View {
        VStack{
            Spacer()
            if let currentWeather = weatherAPIClient.currentWeather  {
                Button { action: do {
                    Task {
//                        delete the city from the list
                    }
                }} label: { Image(systemName: "trash").font(.title2)
                        .shadow(radius: 1)
                }.padding()
                ZStack{
                    VStack{
                        Text(name).font(.largeTitle)
                        Text(Date(), style: .time)
                        Text(currentWeather.weatherCode.description).font(.body).multilineTextAlignment(.center)
                        Text("\(currentWeather.temperature)º").font(.largeTitle)
                        
                    }.padding()
                }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8)).background(
                    currentWeather.weatherCode.background.ignoresSafeArea())
            } else {
                ZStack{
                    VStack(alignment: .center, spacing: 16){
                        Text("No weather info available yet.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                        
                        Button { action: do {
                            Task {
                                await weatherAPIClient.fetchWeather()
                            }
                        }} label: { Image(systemName: "arrow.2.squarepath").font(.title2)
                                .shadow(radius: 1)
                        }
                    }.padding()
                }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8)).background(
                    Image("clear"))
            }
            Spacer()
        }.padding()
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(name: "Bursa", weatherAPIClient: WeatherAPIClient(userLatitude: 40.193298, userLongitude:29.07420))
    }
}
