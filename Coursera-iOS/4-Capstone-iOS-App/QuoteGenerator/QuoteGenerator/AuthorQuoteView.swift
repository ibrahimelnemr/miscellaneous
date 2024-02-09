//
//  AuthorQuoteView.swift
//  QuoteGenerator
//AuthorQuoteView.swift


import SwiftUI

struct AuthorQuotePage: View {
    let author: String
    @State private var quotes: [QuoteData] = [] // Update to hold QuoteData objects
    
    var body: some View {
        VStack {
            Text("\(author) Quotes")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            List(quotes, id: \.quoteText) { quoteData in
                VStack(alignment: .leading) {
                    Text(quoteData.quoteText)
                    Text("- \(quoteData.quoteAuthor)")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .padding()
            
            Button(action: {
                fetchAuthorQuotes()
            }) {
                Text("Regenerate")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("\(author) Quotes")
        .onAppear {
            fetchAuthorQuotes()
        }
    }
    
    private func fetchAuthorQuotes() {
        QuoteService.fetchQuotesByAuthor(author: author) { result in
            switch result {
            case .success(let quotes):
                DispatchQueue.main.async {
                    self.quotes = quotes // Update to assign array of QuoteData objects
                }
            case .failure(let error):
                print("Error fetching category quotes: \(error.localizedDescription)")
            }
        }
    }
}
