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
    private var apiKey: String
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    init() {
        
        let path = "/Users/ibrahim/csproj/miscellaneous/Coursera-iOS/3-iOS-App-Design/CustomApp/CustomApp/.env"
        do {
            var env = try DotEnv.read(path: path)
            env.load()
            apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "Api Key not found"
            print(apiKey)
        } catch {
            print("Error loading API key: \(error)")
            apiKey = ""
        }
        
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
            
            let cities = ["Cairo", "New York", "Tokyo"]
            completion(.success(cities))
            
            // completion(.failure(NSError(domain: "WeatherService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch cities for \(country)."])))
        }
    }
    
    func fetchDummyWeather(for city: String, completion: @escaping (Result<Weather>) -> Void) {
        
        DispatchQueue.global().async {
            
            let weatherData = Weather(temperature: 25, humidity: 60, description: "Sunny")
            completion(.success(weatherData))
            
            // completion(.failure(NSError(domain: "WeatherService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch weather data for \(city)."])))
        }
    }
    
    func fetchWeather(for city: String, completion: @escaping (Result<Weather>) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(apiKey)") else {
            completion(.failure(NSError(domain: "WeatherService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "WeatherService", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Data:\n\(jsonString)")
            } else {
                print("Failed to convert data to string")
            }

            
            //completion(.success(data))
            
            
            // SEND DUMMY DATA
            let weatherData = Weather(temperature: 25, humidity: 60, description: "Sunny")
            completion(.success(weatherData))
            
            // completion(.failure(NSError(domain: "WeatherService", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch weather data for \(city)."])))
        }.resume()
    }
}
