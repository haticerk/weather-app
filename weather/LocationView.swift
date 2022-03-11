//
//  LocationView.swift
//  weather
//
//  Created by Hatice on 10.02.2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @StateObject private var weatherAPIClient = WeatherAPIClient(userLatitude: LocationManager.shared.lastLocation?.coordinate.latitude ?? 0, userLongitude: LocationManager.shared.lastLocation?.coordinate.longitude ?? 0)
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
                
            if let currentWeather = weatherAPIClient.currentWeather  {
                VStack(alignment: .center, spacing: 16) {
                    HStack{
                        Spacer()
                        Button { action: do {
                            Task {
                                await weatherAPIClient.fetchWeather()
                            }
                        }} label: { Image(systemName: "arrow.2.squarepath").font(.title2)
                                .shadow(radius: 1)
                        }.padding()
                    }
                    Spacer()
                    VStack(alignment: .center){
                        Text("My Location").font(.largeTitle)
                        Text("\(currentWeather.temperature)º")
                            .font(.largeTitle)
                        currentWeather.weatherCode.image
                            .font(.largeTitle)
                        
                        Text(currentWeather.weatherCode.description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                        Text(Date(), style: .time)
                    }.padding().background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                    Spacer()
                }.background(
                    currentWeather.weatherCode.background.ignoresSafeArea()
                )
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
        }
        .onAppear {
            Task {
                await weatherAPIClient.fetchWeather()
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
