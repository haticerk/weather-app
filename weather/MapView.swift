//
//  MapView.swift
//  weather
//
//  Created by Hatice on 14.02.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var originalCities = ReadData.shared.cities
//    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: LocationManager.shared.lastLocation?.coordinate.latitude ?? 0, longitude: LocationManager.shared.lastLocation?.coordinate.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.193298, longitude:29.07420), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    @State private var showingSheet = true
    var body: some View {
        VStack{
            Map(coordinateRegion: $region,
                annotationItems: originalCities){
                city in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(city.latitude) ?? 0, longitude: Double(city.longitude) ?? 0)){
                    VStack {

                        Button {
                            action: do {
                                self.showingSheet = true
                                
                            }
                        } label: { Image(systemName: "star.fill").font(.title2)
                                    .foregroundColor(.yellow)
                                    .shadow(radius: 1)
                        }
                          

                        .sheet(isPresented: $showingSheet){
                            List{
                                WeatherRow(name: city.name, weatherAPIClient: WeatherAPIClient(userLatitude: Double(city.latitude) ?? 0, userLongitude: Double(city.longitude) ?? 0))
                            }
                            Button("Dismiss") {
                                    showingSheet = false
                            }

                        }
                    }
                }
            }.ignoresSafeArea()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
