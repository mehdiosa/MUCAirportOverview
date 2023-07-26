//
//  AirportData.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 25.07.23.
//

import SwiftSoup
import SwiftUI

class AirportData: ObservableObject {
    @Published var isFetching: Bool = true

    func formatDate(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: timestamp)
    }

    func loadData(current: String, until: String) async -> String {
        guard let url = URL(string: "https://www.munich-airport.de/flightsearch/arrivals?from=" + current + "&per_page=1000&min_date=" + current + "&max_date=" + until) else {
            return "Invalid URL"
        }

        let _ = print(url)

        do {
            let contents = try String(contentsOf: url)
            return contents
        } catch {
            // contents could not be loaded
            print("Could not load contents")
        }
        return "Error"
    }

    func parseData() async -> [[String: String]] {
        let _ = print(formatDate(Date.now))
        let airportHTML = Task { await self.loadData(current: formatDate(Date.now), until: formatDate(Calendar.current.date(byAdding: .day, value: 1, to: Date.now) ?? Date.now)) }
        var flightData: [[String: String]] = []

        do {
            // Get Table Data
            guard let elements: Elements = try? await SwiftSoup.parse(airportHTML.value).getElementsByClass("fp-flights-table-large") else {
                return [[:]]
            }

            // Get data of flights
            let flightItems = try elements.array()[0].getElementsByClass("fp-flight-item")

            // parse data and create dictionaries which carry all information of each flight
            for flights in flightItems {
                let airline = try flights.getElementsByClass("fp-flight-airline")[0].text()
                let departureCity = try flights.getElementsByClass("fp-flight-airport")[0].text()
                let number = try flights.getElementsByClass("fp-flight-number")[0].text()
                let status = try flights.getElementsByClass("fp-flight-status")[0].text()
                // Departure time
                let time_other = try flights.getElementsByClass("fp-flight-time-other")[0].text()

                // Time flight is planned and expected at munich airport
                let times_muc = try flights.getElementsByClass("fp-flight-time-muc")[0].text().components(separatedBy: "|")

                let area = try flights.getElementsByClass("fp-flight-area")[0].text()

                // Append flight data array with data dictionaries
                flightData.append([
                    "airline": airline,
                    "departureCity": departureCity,
                    "number": number,
                    "status": status,
                    "time_other": time_other,
                    "plannedArrivalTime": times_muc[0].trimmingCharacters(in: .whitespaces),
                    "expectedArrivalTime": times_muc[1].trimmingCharacters(in: .whitespaces),
                    "area": area
                ])
            }

            return flightData
        } catch let Exception.Error(type, message) {
            print(message)
        } catch {
            print("error")
        }
        return [[:]]
    }
}
