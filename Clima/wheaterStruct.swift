//
//  wheaterStruct.swift
//  Clima
//
//  Created by Sergei on 21.01.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WheatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description : String
    let id: Int 
}
