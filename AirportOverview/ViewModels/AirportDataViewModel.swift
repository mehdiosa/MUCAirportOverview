//
//  AirportDataViewModel.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 25.07.23.
//

import SwiftSoup
import SwiftUI

extension ContentView {
    @MainActor class AirportDataViewModel: ObservableObject {
        var mucAirportData: MucAirportData = .init()
        @Published var isFetching: Bool = true

        init() {
            Task {
                mucAirportData.data.arrivalData = await mucAirportData.loadData("arrivals")
                mucAirportData.data.departureData = await mucAirportData.loadData("departures")
                isFetching = false
            }
        }
    }
}
