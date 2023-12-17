//
//  WeatherManager.swift
//  Clima
//
//  Created by Necati Alperen IŞIK on 5.09.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=34f4cc812bcdf26a30406bb21c771c4b&units=metric"
    var delegate: WeatherManagerDelegate?
    func fetchWeather(cityName:String){
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString:String){
        // 1.create url
        
        if let url = URL(string: urlString){
            
            //2.create urlsession
            
            let session = URLSession(configuration: .default)
            
            
            //3.give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    
                }
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                    
                    
                    
                    
                }
            }
            
            
            //4.start the task
            
            task.resume()
        }
        
    }
    
    
    
    
    
    func parseJSON(weatherData:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            print(error)
            
        }
        return nil
    }
    
    
}
