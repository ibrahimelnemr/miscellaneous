//
//  JokeService.swift
//  JokeGeneratorUIKit
//

import Foundation

class JokeService {
    static func fetchRandomJoke(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw,religious,political,racist,sexist,explicit&type=single") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let jokeResponse = try JSONDecoder().decode(JokeResponse.self, from: data)
                let joke = jokeResponse.joke
                completion(.success(joke))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func fetchJokesByCategory(category: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let formattedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://v2.jokeapi.dev/joke/\(formattedCategory)?blacklistFlags=nsfw,religious,political,racist,sexist,explicit&type=single") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let jokeResponse = try JSONDecoder().decode(JokeResponse.self, from: data)
                let joke = jokeResponse.joke
                completion(.success(joke))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct JokeResponse: Codable {
    let error: Bool
    let category: String
    let type: String
    let joke: String
    let flags: Flags
    let safe: Bool
    let id: Int
    let lang: String
}

struct Flags: Codable {
    let nsfw: Bool
    let religious: Bool
    let political: Bool
    let racist: Bool
    let sexist: Bool
    let explicit: Bool
}
