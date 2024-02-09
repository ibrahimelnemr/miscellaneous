// WeatherDetailView.swift

import SwiftUI

struct WeatherDetailView: View {
    let city: String
    @StateObject var viewModel = WeatherDetailViewModel()

    var body: some View {
        VStack {
            Text("Weather Details for \(city)")
            if let weather = viewModel.weather {
                Text("Temperature: \(weather.temperature)°C")
                Text("Humidity: \(weather.humidity)%")
                Text("Description: \(weather.description)")
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Weather Details")
        .onAppear {
            viewModel.fetchWeather(for: city) { result in
                switch result {
                case .success(let weather):
                    viewModel.weather = weather
                case .failure(let error):
                    print("Error fetching weather: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(city: "City")
    }
}

