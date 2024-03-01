//
//  CitiesView.swift
//  CustomApp
//

import SwiftUI

struct CitiesView: View {
    let country: String
    @StateObject var viewModel = CitiesViewModel()

    var body: some View {
        VStack {
            Text("Select a City in \(country):")
            List(viewModel.cities, id: \.self) { city in
                NavigationLink(destination: WeatherDetailView(city: city)) {
                    Text(city)
                }
            }
        }
        .navigationTitle("\(country) Cities")
        .onAppear {
            viewModel.fetchCities(for: country)
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(country: "Country")
    }
}
