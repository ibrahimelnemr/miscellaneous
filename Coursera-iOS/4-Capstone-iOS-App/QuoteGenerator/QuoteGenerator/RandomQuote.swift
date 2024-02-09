//
//  RandomQuote.swift
//  QuoteGenerator
//

import SwiftUI

struct RandomQuotePage: View {
    @State private var quoteText: String = ""
    @State private var quoteAuthor: String = ""
    
    var body: some View {
           VStack {
               Text(quoteText)
                   .padding()
               
               Text("- \(quoteAuthor)")
                   .padding(.bottom)
                   .foregroundColor(.gray)
               
               Button(action: {
                   fetchRandomQuote()
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
           .navigationTitle("Random Quote")
           .onAppear {
               fetchRandomQuote()
           }
       }
    private func fetchRandomQuote() {
            QuoteService.fetchRandomQuote { result in
                switch result {
                case .success(let quote):
                    DispatchQueue.main.async {
                        self.quoteText = quote
                    }
                case .failure(let error):
                    print("Error fetching random quote: \(error.localizedDescription)")
                }
            }
        }
}
