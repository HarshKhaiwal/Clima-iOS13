
import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temp: String{
        return String(format: "%.1f", temperature)
    }
    /* Computed property syntax
        var aProperty : dataType {
        return value of a property like 2*4
        }
     
     */
    var conditionName: String{
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "smoke"
        case 800:
            return "sun.min"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }

}
