//codable = decodable & encodable protocols
// Parameter name
// func myFunc(external para  internal para: Type){
//  print(internal para)
// }
// we can omit external paramter name by using _
// and we can call function by myFunc(value) just passing the value

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    

    
    var delegate: WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f0c1bed1920f04973e86ff432a642290&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with:urlString)
    }
    func fetchWeather(_ latitude:CLLocationDegrees, _ longitude:CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with:urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {  //create a URL
            let session = URLSession(configuration: .default) //create URl session
            let task = session.dataTask(with: url) { (data, response, error) in  //giving a task
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString!)
                }
            }
            task.resume()    //start the task
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
     let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather

        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    

    }

