//
//  SelectAuthorView.swift
//  QuoteGenerator
//
//

import SwiftUI

struct SelectAuthorPage: View {
    @State private var authors: [String] = []

    
    var body: some View {
        
        VStack {
            List {
                Section(header: Text("Authors")) {
                    ForEach(authors, id: \.self) { author in
                        NavigationLink(destination: AuthorQuotePage(author: author)) {
                            Text(author)
                        }
                    }
                }
                
            }
            .navigationTitle("Select Author")
            .onAppear() {
                fetchAuthors()
            }
        }
    }
    
    private func fetchAuthors() {
        QuoteService.fetchAllAuthors() { result in
             switch result {
             case .success(let authors):
                 DispatchQueue.main.async {
                     self.authors = authors
                 }
             case .failure(let error):
                 print("Error fetching authors: \(error.localizedDescription)")
             }
         }
    }
}
