import Foundation

class QuoteService {
    static func fetchRandomQuote(completion: @escaping (Result<(quote: String, author: String), Error>) -> Void) {
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
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let quoteResponse = try JSONDecoder().decode(RandomQuoteResponse.self, from: data)
                if let quoteData = quoteResponse.data.first {
                    let quote = quoteData.quoteText
                    let author = quoteData.quoteAuthor
                    completion(.success((quote: quote, author: author)))
                } else {
                    completion(.failure(NSError(domain: "Failed to fetch quote", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func fetchQuotesByAuthor(author: String, completion: @escaping (Result<[QuoteData], Error>) -> Void) {
            guard let formattedAuthor = author.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: "https://quote-garden.onrender.com/api/v3/quotes?author=\(formattedAuthor)") else {
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
                    let quotesResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
                    completion(.success(quotesResponse.data))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
        
    static func fetchQuotesByCategory(category: String, completion: @escaping (Result<[QuoteData], Error>) -> Void) {
        guard let formattedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://quote-garden.onrender.com/api/v3/quotes?genre=\(formattedCategory)") else {
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
                let quotesResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
                completion(.success(quotesResponse.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
        
        static func fetchAllAuthors(completion: @escaping (Result<[String], Error>) -> Void) {
            guard let url = URL(string: "https://quote-garden.onrender.com/api/v3/authors") else {
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
                    let authorsResponse = try JSONDecoder().decode(AuthorsResponse.self, from: data)
                    completion(.success(authorsResponse.data))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
        
    static func fetchAllCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "https://quote-garden.onrender.com/api/v3/genres") else {
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
                let genresResponse = try JSONDecoder().decode(GenresResponse.self, from: data)
                completion(.success(genresResponse.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }}

struct QuoteResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [QuoteData]
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

//struct AuthorsResponse: Codable {
//    let authors: [String]
//}
struct AuthorsResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [String]
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case message
        case data
    }
}


struct GenresResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [String]
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case message
        case data
    }
}
