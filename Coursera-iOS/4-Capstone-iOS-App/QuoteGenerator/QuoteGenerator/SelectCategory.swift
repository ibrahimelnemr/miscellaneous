//
//  SelectCategory.swift
//  QuoteGenerator

import SwiftUI

struct SelectCategoryPage: View {
    let dummyCategories = ["Inspiration", "Motivation", "Love"]
    @State private var genres: [String] = []

    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Categories")) {
                    ForEach(genres, id: \.self) { genre in
                        NavigationLink(destination: CategoryQuotePage(category: genre)) {
                            Text(genre)
                        }
                    }
                }
                
            }
            .navigationTitle("Select Category")
            .onAppear() {
                fetchGenres()
            }
        }
    }
    
    private func fetchGenres() {
        QuoteService.fetchAllCategories { result in
             switch result {
             case .success(let categories):
                 DispatchQueue.main.async {
                     self.genres = categories
                 }
             case .failure(let error):
                 print("Error fetching genres: \(error.localizedDescription)")
             }
         }
    }
}
