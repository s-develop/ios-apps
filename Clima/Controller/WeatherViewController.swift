//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
 
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var wheatherImage: UIImageView!
    
    var weatherManager = WeatherManager()
     
    
    let apiKey:String = "847f660012fbf427243bd2a428227eb5"
    let query:String = "api.openweathermap.org/data/2.5/weather?q={city name},{state code}&appid={API key}&units=metric"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: Any) {
        executeWeatherUpdate()
    }
    
    func textFieldShouldDidEndEditing(_ textField: UITextField) ->Bool{
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func executeWeatherUpdate(){
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        executeWeatherUpdate()
        return true
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WheatherModel) {
        
        print("DelegateCall")
        
        DispatchQueue.main.async {
            
            let temp = String(weather.tempetature)
            let image = UIImage(systemName: weather.conditionName)
            let cityName = weather.cityName
            
            if(cityName != "Default"){
                self.temperatureLabel.text = temp
                self.conditionImageView.image = image
                self.cityLabel.text = cityName
            }else{
                self.temperatureLabel.text = "N/A"
                self.cityLabel.text = "N/A"
            }
           
        }
        
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

