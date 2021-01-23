//
//  wheatherModel.swift
//  Clima
//
//  Created by Sergei on 22.01.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


struct WheatherModel{
    
    let conditionId: Int
    let cityName: String
    let tempetature: Double
    
    var temparatureString:String{
        return String(format: "%.1f", tempetature)
    }
    
    var conditionName: String{
        
        switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
    
    
}
