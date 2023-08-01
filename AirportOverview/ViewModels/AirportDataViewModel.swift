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

        var hamAirportData: MucAirportData = .init()

        @Published var isFetching: Bool = true

        init() {
            Task {
                mucAirportData.data.arrivalData = await mucAirportData.loadData("arrivals")
                mucAirportData.data.departureData = await mucAirportData.loadData("departures")

                hamAirportData.data.arrivalData = await hamAirportData.loadData("departures")
                hamAirportData.data.departureData = await hamAirportData.loadData("arrivals")
                isFetching = false
            }
        }
    }
}
