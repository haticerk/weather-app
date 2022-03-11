//
//  WeatherAPIClient.swift
//  weather
//
//  Created by Hatice on 10.02.2022.
//

import Foundation
import CoreLocation

class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: Weather?
    var userLatitude: Double
    var userLongitude: Double
    
    init(userLatitude: Double, userLongitude: Double){
        self.userLatitude = userLatitude
        self.userLongitude = userLongitude
    }
    
    func fetchWeather() async {
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(userLatitude),\(userLongitude)&fields=temperature&fields=weatherCode&timesteps=current&units=metric&apikey=42FU0FyYuCxBNnAU4LNykMFU5zNKBtpl") else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data),
                           let weatherValue = weatherResponse.data.timelines.first?.intervals.first?.values,
                           let weatherCode = WeatherCode(rawValue: "\(weatherValue.weatherCode)") {
                            DispatchQueue.main.async { [weak self] in
                                self?.currentWeather = Weather(temperature: Int(weatherValue.temperature),
                                                               weatherCode: weatherCode)
                            }
                        }
        } catch {
            // handle the error
        }
    }
}
