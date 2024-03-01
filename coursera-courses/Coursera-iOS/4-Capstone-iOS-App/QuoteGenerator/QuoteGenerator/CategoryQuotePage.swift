//
//  CategoryQuotePage.swift
//  QuoteGenerator

import SwiftUI

struct CategoryQuotePage: View {
    let category: String
    @State private var quotes: [QuoteData] = [] // Update to hold QuoteData objects
    
    var body: some View {
        VStack {
            Text("\(category) Quotes")
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
                fetchCategoryQuotes()
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
        .navigationTitle("\(category) Quotes")
        .onAppear {
            fetchCategoryQuotes()
        }
    }
    
    private func fetchCategoryQuotes() {
        QuoteService.fetchQuotesByCategory(category: category) { result in
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

struct CategoryQuotePage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryQuotePage(category: "Inspiration")
    }
}
