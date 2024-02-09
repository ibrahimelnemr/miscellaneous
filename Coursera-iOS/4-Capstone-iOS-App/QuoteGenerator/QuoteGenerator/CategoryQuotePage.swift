//
//  CategoryQuotePage.swift
//  QuoteGenerator

import SwiftUI

struct CategoryQuotePage: View {
    let category: String
    @State private var quoteText: String = ""
    
    var body: some View {
        VStack {
            Text("\(category) Quotes")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Category Quote Text")
                .padding()
            
            Button(action: {
                fetchCategoryQuote()
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
        .onAppear{
            fetchCategoryQuote()
        }
    }
    private func fetchCategoryQuote() {
        QuoteService.fetchCategoryQuote(category: category) { result in
            switch result {
            case .success(let quote):
                DispatchQueue.main.async {
                    self.quoteText = quote
                }
            case .failure(let error):
                print("Error fetching category quote: \(error.localizedDescription)")
            }
        }
    }
}
