//
//  AirportData.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 25.07.23.
//

import SwiftSoup
import SwiftUI

struct AirportData: View {
    let airportData: [[String: String]] = AirportData.parseData()

    var body: some View {
        List {
            ForEach(airportData, id: \.self) { flightData in
                Text(flightData["airline"]!)
                Text(flightData["number"]!)
                Text(flightData["status"]!)
                Text(flightData["time_other"]!)
                Text(flightData["time_muc"]!)
                Text(flightData["area"]!)
            }
        }
    }

    static func loadData() -> String {
        // TODO: Change "loadData" to work with "any" timestamp -> Basically the idea is to take the current timestamp minus 2(?) hours and then display all flights from there until end of day or the same timestamp in the next day (Basically creating a 24 hour forecast). For this, "from", "min_date" and "max_date" in the url must be set dynamically
        guard let url = URL(string: "https://www.munich-airport.de/flightsearch/arrivals?from=2023-07-25T20%3A20%3A100&per_page=1000&min_date=2023-07-25T20%3A00%3A00&max_date=2023-07-25T21%3A00%3A00") else {
            return "Invalid URL"
        }

        do {
            let contents = try String(contentsOf: url)
            return contents
        } catch {
            // contents could not be loaded
            print("Could not load contents")
        }
        return "Error"
    }

    static func parseData() -> [[String: String]] {
        let airportHTML = AirportData.loadData()
        var flightData: [[String: String]] = []

        do {
            // Get Table Data
            guard let elements: Elements = try? SwiftSoup.parse(airportHTML).getElementsByClass("fp-flights-table-large") else {
                // TODO: CHANGE THIS RETURN WITH SOMETHING BETTER IF AVAILABLE
                return [["": ""]]
            }

            // Get data of flights
            let flightItems = try elements.array()[0].getElementsByClass("fp-flight-item")

            // parse data and create dictionaries which carry all information of each flight
            for flights in flightItems {
                let airline = try flights.getElementsByClass("fp-flight-airline")[0].text()
                let number = try flights.getElementsByClass("fp-flight-number")[0].text()
                let status = try flights.getElementsByClass("fp-flight-status")[0].text()
                // Departure time
                let time_other = try flights.getElementsByClass("fp-flight-time-other")[0].text()
                
                // Time flight is planned and expected at munich airport
                let time_muc = try flights.getElementsByClass("fp-flight-time-muc")[0].text()
                let area = try flights.getElementsByClass("fp-flight-area")[0].text()

                // Append flight data array with data dictionaries
                flightData.append([
                    "airline": airline,
                    "number": number,
                    "status": status,
                    "time_other": time_other,
                    "time_muc": time_muc,
                    "area": area
                ])
            }

            return flightData
        } catch let Exception.Error(type, message) {
            print(message)
        } catch {
            print("error")
        }

        // TODO: CHANGE THIS RETURN WITH SOMETHING BETTER IF AVAILABLE
        return [["NO DATA": "NO DATA"]]
    }
}

struct AirportData_Previews: PreviewProvider {
    static var previews: some View {
        AirportData()
    }
}
