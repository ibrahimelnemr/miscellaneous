//ContentView.swift

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Select a Country:")
                List(viewModel.countries, id: \.self) { country in
                    NavigationLink(destination: CitiesView(country: country)) {
                        Text(country)
                    }
                }
            }
            .navigationTitle("Countries")
        }
        .onAppear {
            viewModel.fetchCountries()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
