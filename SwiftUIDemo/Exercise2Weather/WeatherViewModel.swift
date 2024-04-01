//
//  WeatherViewModel.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 28/3/24.
//

import SwiftUI

struct WeatherViewModel {
    struct weatherDay: Identifiable {
        let id = UUID()
        let icon: Image
        let temperature: Int
        let measureUnit: String
    }
    
    let weatherList = [
        weatherDay(icon: Image("cloudySun"), temperature: 15, measureUnit: "º"),
        weatherDay(icon: Image("cloudAndRain"), temperature: 25, measureUnit: "º"),
        weatherDay(icon: Image("cloudSnow"), temperature: 2, measureUnit: "º"),
        weatherDay(icon: Image("cloudAndRain"), temperature: -5, measureUnit: "º"),
        weatherDay(icon: Image("cloudySun"), temperature: 25, measureUnit: "º"),
        weatherDay(icon: Image("cloudSnow"), temperature: -2, measureUnit: "º")
    ]
    
    let averageDayTemperature = [10, 25, 0]
}
