//
//  WeatherModel.swift
//  weather
//
//  Created by Hatice on 10.02.2022.
//

import Foundation
import SwiftUI

struct WeatherModel: Codable {
    let data: WeatherData
}

struct WeatherData: Codable {
    let timelines: [WeatherTimelines]
}

struct WeatherTimelines: Codable {
    let intervals: [WeatherIntervals]
}

struct WeatherIntervals: Codable {
    let startTime: String
    let values: WeatherValue
}

struct WeatherValue: Codable {
    var temperature: Double
    var weatherCode: Int
}

enum WeatherCode: String, Codable {
    case clear = "1000"
    case mostlyClear = "1100"
    case partlyCloudy = "1101"
    case mostlyCloudy = "1102"
    case cloudy = "1001"
    case fog = "2000"
    case lightFog = "2100"
    case lightWind = "3000"
    case wind = "3001"
    case strongWind = "3002"
    case drizzle = "4000"
    case rain = "4001"
    case lightRain = "4200"
    case heavyRain = "4201"
    case snow = "5000"
    case flurries = "5001"
    case lightSnow = "5100"
    case heavySnow = "5101"
    case freezingDrizzle = "6000"
    case freezingRain = "6001"
    case lightFreezingRain = "6200"
    case heavyFreezingRain = "6201"
    case icePellets = "7000"
    case heavyIcePellets = "7101"
    case lightIcePellets = "7102"
    case thunderstorm = "8000"
    
    var description: String {
        switch self {
        case .clear:
            return "Clear"
        case .cloudy:
            return "Cloudy"
        case .mostlyCloudy:
            return "Mostly Cloudy"
        case .mostlyClear:
            return "Mostly Clear"
        case .partlyCloudy:
            return "Partly Cloudy"
        case .fog:
            return "Fog"
        case .lightFog:
            return "Light Fog"
        case .lightWind:
            return "Light Wind"
        case .wind:
            return "Wind"
        case .strongWind:
            return "Strong Wind"
        case .drizzle:
            return "Drizzle"
        case .lightRain:
            return "Light Rain"
        case .rain:
            return "Rain"
        case .heavyRain:
            return "Heavy Rain"
        case .snow:
            return "Snow"
        case .flurries:
            return "Flurries"
        case .lightSnow:
            return "Light Snow"
        case .heavySnow:
            return "Heavy Snow"
        case .freezingDrizzle:
            return "Freezing Drizzle"
        case .freezingRain:
            return "Freezing Rain"
        case .lightFreezingRain:
            return "Light Freezing Rain"
        case .heavyFreezingRain:
            return "Heavy Freezing Rain"
        case .icePellets:
            return "Ice Pellets"
        case .heavyIcePellets:
            return "Heavy Ice Pellets"
        case .lightIcePellets:
            return "Light Ice Pellets"
        case .thunderstorm:
            return "Thunder Storm"
        }
    }
    
    var image: Image {
        switch self {
        case .clear:
            return Image(systemName: "sun.max.fill")
        case .cloudy:
            return Image(systemName: "cloud.fill")
        case .mostlyClear, .partlyCloudy, .mostlyCloudy:
            return Image(systemName: "cloud.sun.fill")
        case .fog, .lightFog:
            return Image(systemName: "cloud.fog.fill")
        case .lightWind, .wind:
            return Image(systemName: "wind")
        case .strongWind:
            return Image(systemName: "tornado")
        case .drizzle:
            return Image(systemName: "cloud.drizzle.fill")
        case .lightRain, .rain:
            return Image(systemName: "cloud.rain.fill")
        case .heavyRain:
            return Image(systemName: "cloud.heavyrain.fill")
        case .snow, .flurries, .lightSnow, .heavySnow:
            return Image(systemName: "snow")
        case .freezingDrizzle:
            return Image(systemName: "thermometer.snowflake")
        case .freezingRain, .lightFreezingRain, .heavyFreezingRain:
            return Image(systemName: "cloud.rain.fill")
        case .icePellets, .heavyIcePellets, .lightIcePellets:
            return Image(systemName: "cloud.hail.fill")
        case .thunderstorm:
            return Image(systemName: "cloud.bolt.fill")
        }
    }
    var background: Image {
        switch self {
        case .clear, .mostlyClear:
            return Image("clear")
        case .cloudy, .partlyCloudy, .mostlyCloudy, .fog, .lightFog:
            return Image("cloud")
        case .lightWind, .wind, .strongWind, .thunderstorm:
            return Image("wind")
        case .drizzle, .lightRain, .rain, .heavyRain, .freezingRain, .lightFreezingRain, .heavyFreezingRain, .freezingDrizzle:
            return Image("rain")
        case .snow, .flurries, .lightSnow, .heavySnow, .icePellets, .heavyIcePellets, .lightIcePellets:
            return Image("snow")
        }
    }
}

struct Weather: Identifiable {
    let id = UUID()
    
    let temperature: Int
    let weatherCode: WeatherCode
}
