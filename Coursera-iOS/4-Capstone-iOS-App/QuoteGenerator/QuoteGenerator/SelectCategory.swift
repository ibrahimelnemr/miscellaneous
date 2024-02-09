//
//  SelectCategory.swift
//  QuoteGenerator

import SwiftUI

struct SelectCategoryPage: View {
    let categories = ["Inspiration", "Motivation", "Love"] // Hardcoded categories
    
    var body: some View {
        VStack {
            List(categories, id: \.self) { category in
                NavigationLink(destination: CategoryQuotePage(category: category)) {
                    Text(category)
                }
            }
        }
        .navigationTitle("Select Category")
    }
}
