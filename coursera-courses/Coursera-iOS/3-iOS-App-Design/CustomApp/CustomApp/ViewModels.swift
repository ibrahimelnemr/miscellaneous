// ViewModels.swift

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var countries: [String] = []
    private let weatherService = WeatherService()

    func fetchCountries() {
        weatherService.fetchCountries { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.countries = countries
                case .failure(let error):
                    print("Error fetching countries: \(error.localizedDescription)")
                }
            }
        }
    }
}

class CitiesViewModel: ObservableObject {
    @Published var cities: [String] = []
    private let weatherService = WeatherService()

    func fetchCities(for country: String) {
        weatherService.fetchCities(for: country) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self.cities = cities
                case .failure(let error):
                    print("Error fetching cities: \(error.localizedDescription)")
                    // Handle the error as needed
                }
            }
        }
    }
}

class WeatherDetailViewModel: ObservableObject {
    @Published var weather: Weather?

    func fetchWeather(for city: String, completion: @escaping (Result<Weather>) -> Void) {
        // Use WeatherService to fetch weather data
        WeatherService().fetchWeather(for: city, completion: completion)
    }
}

struct Weather {
    let temperature: Int
    let humidity: Int
    let description: String
}
