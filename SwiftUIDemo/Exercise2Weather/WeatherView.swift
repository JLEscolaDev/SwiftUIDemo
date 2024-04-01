//
//  WeatherView.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 28/3/24.
//

import SwiftUI

struct WeatherView: View {
    let flexibleItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var isPortrait = true
    
    let weatherVM = WeatherViewModel()
    
    var body: some View {
        VStack {
            Image("cloudsAndSun")
                .resizable()
                .scaledToFill()
                .frame(width: .infinity, height: isPortrait ? 250 : 150,alignment: .top)
                .mask(
                    LinearGradient(gradient: Gradient(colors: [.clear, Color.black, Color.black, Color.black]), startPoint: .top, endPoint: .bottom)
                )
            if isPortrait {
                HStack {
                    Image("plants")
                        .resizable()
                        .scaledToFit()
                        .clipShape (
                            RoundedRectangle(cornerSize: .init(width: 15, height: 15))
                        )
                        .padding(.horizontal, 20)
                    
                    Text("24º")
                        .font(.system(size: 50))
                        .fontWeight(.black)
                        .padding(.horizontal, 20)
                        .foregroundStyle(.blue)
                        .shadow(color: .indigo, radius: 1, x: 6)
                    
                }
            }
            LazyHStack(alignment: .top) {
                LazyVStack(spacing: 10) {
                    LazyVGrid(columns: flexibleItems, spacing: isPortrait ? 30 : 10) {
                        ForEach(weatherVM.weatherList) { weatherDay in
                            HStack {
                                Text("\(weatherDay.temperature)\(weatherDay.measureUnit)").textScale(.secondary)
                                    .dynamicTypeSize(.small ... .accessibility4)
                                weatherDay.icon.resizable().scaledToFit().fixedSize(horizontal: false, vertical: false)
                            }
                        }
                    }
                    Text("Temperatura media").bold().padding(.top, 20)
                        .dynamicTypeSize(.small ... .accessibility2)
                    LazyVGrid(columns: flexibleItems) {
                        ForEach(weatherVM.averageDayTemperature, id: \.self) { averageTemp in
                            Text("\(averageTemp)º")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                    }
                }.padding(.leading, isPortrait ? 0 : 80)
                if !isPortrait {
                    VStack {
                        Image("plants")
                            .resizable()
                            .scaledToFit()
                            .clipShape (
                                RoundedRectangle(cornerSize: .init(width: 15, height: 15))
                            )
                            .padding(.horizontal, 20)
                        
                        Text("24º")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                            .padding(.horizontal, 20)
                            .foregroundStyle(.blue)
                            .shadow(color: .indigo, radius: 1, x: 6)
                        
                    }
                }
            }
            
            
            
            
        }.ignoresSafeArea()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                self.isPortrait = windowScene?.interfaceOrientation.isPortrait ?? true
            }
            .dynamicTypeSize(...DynamicTypeSize.accessibility3)
    }
}

#Preview {
    WeatherView()
}
