//
//  WeatherManager.swift
//  Clima
//
//  Created by Sergei on 21.01.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WheatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=847f660012fbf427243bd2a428227eb5&units=metric"
    
    var delegate: WeatherManagerDelegate?
 
    func fetchWeather(cityName:String) -> String {
       let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        return urlString
    }
    
    func performRequest(with urlString : String) -> String {
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString)
                    if let weather: WheatherModel? = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather!)
                    }
                    
                }
            }
            
            task.resume()
        
        }
        
        return ""
        
        
    }
    
    
    func parseJSON(_ weatherData: Data) -> WheatherModel{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WheatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let weather = WheatherModel(conditionId: id, cityName: name, tempetature: temp)
            
            return weather
            
        }
        catch{
            print(error)
            let weather = WheatherModel(conditionId: 1, cityName: "Default", tempetature: -279 )
            return weather
        }
    }
    
    
     
}
