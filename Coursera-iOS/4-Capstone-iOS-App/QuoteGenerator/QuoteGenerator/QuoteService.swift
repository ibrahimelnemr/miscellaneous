//
//  QuoteService.swift
//  QuoteGenerator
//
import Foundation

class QuoteService {
    static func fetchRandomQuote(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://quote-garden.onrender.com/api/v3/quotes/random") else {
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
            print(httpResponse)
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            print(data)
            
            do {
                let quoteResponse = try JSONDecoder().decode(RandomQuoteResponse.self, from: data)
                if let quoteText = quoteResponse.data.first?.quoteText {
                    completion(.success(quoteText))
                    print(data)
                } else {
                    completion(.failure(NSError(domain: "Failed to fetch quote", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func fetchCategoryQuote(category: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let categoryEncoded = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://quote-garden.herokuapp.com/api/v3/quotes/random?genre=\(categoryEncoded)") else {
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
                let quoteResponse = try JSONDecoder().decode(RandomQuoteResponse.self, from: data)
                if let quoteText = quoteResponse.data.first?.quoteText {
                    completion(.success(quoteText))
                } else {
                    completion(.failure(NSError(domain: "Failed to fetch quote", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct RandomQuoteResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [QuoteData]
}

struct QuoteData: Codable {
    let quoteText: String
    let quoteAuthor: String
}
