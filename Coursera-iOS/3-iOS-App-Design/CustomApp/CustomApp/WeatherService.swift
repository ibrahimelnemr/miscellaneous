//
//  WeatherService.swift
//  CustomApp
//
import Foundation
import DotEnv


enum Result<T> {
    case success(T)
    case failure(Error)
}

class WeatherService {
    init() {
        
        
    }
    
    func fetchCountries(completion: @escaping (Result<[String]>) -> Void) {
        
        DispatchQueue.global().async {
            
            let countries = ["Country 1", "Country 2", "Country 3"]
            completion(.success(countries))
            
            // completion(.failure(NSError(domain: "WeatherService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch countries."])))
        }
    }

    func fetchCities(for country: String, completion: @escaping (Result<[String]>) -> Void) {
        
        DispatchQueue.global().async {
            
            let cities = ["City 1", "City 2", "City 3"]
            completion(.success(cities))
            
            // completion(.failure(NSError(domain: "WeatherService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch cities for \(country)."])))
        }
    }
    
    func fetchWeather(for city: String, completion: @escaping (Result<Weather>) -> Void) {
        
        DispatchQueue.global().async {
            
            let weatherData = Weather(temperature: 25, humidity: 60, description: "Sunny")
            completion(.success(weatherData))
            
            // completion(.failure(NSError(domain: "WeatherService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch weather data for \(city)."])))
        }
    }
}
