//
//  WeatherData.swift
//  Clima
//
//  Created by Necati Alperen IŞIK on 5.09.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

// weather datanın geri geleceği structuru oluşturuyoruz

struct WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather : Codable {
    let id : Int
}
