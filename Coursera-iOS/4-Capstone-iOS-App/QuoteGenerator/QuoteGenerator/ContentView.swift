//
//  ContentView.swift
//  QuoteGenerator
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "quote.bubble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text("Quote Generator")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                NavigationLink(destination: RandomQuotePage()) {
                    Text("Generate Random Quote")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                
                NavigationLink(destination: SelectCategoryPage()) {
                    Text("Generate By Category")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                NavigationLink(destination: SelectAuthorPage()) {
                    Text("Generate By Author")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .navigationTitle("Quote Generator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
