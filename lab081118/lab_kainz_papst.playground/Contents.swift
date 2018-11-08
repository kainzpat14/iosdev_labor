import Foundation
import Dispatch
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let locationQueue = DispatchQueue(
    label: "at.fhj.ims.locationQueue",
    qos: .userInitiated,
    attributes: .concurrent)
let serialQueue = DispatchQueue(label: "at.fhj.ims.serialQueue", qos: .userInitiated);


let queries = ["London","New%20York","Vienna","Berlin","Frohnleiten"]
var queriesToComplete = queries;
let locationUrl = "https://www.metaweather.com/api/location/search/?query="
let weatherUrl = "https://www.metaweather.com/api/location/"

extension String : Error {
    
}

func loadDataFromUrl(_ urlString : String) throws -> Any  {
    if let url = URL(string: urlString) {
        let d = try Data(contentsOf: url)
        return try JSONSerialization.jsonObject(with: d)
    } else {
        throw "Invalid url: \(urlString)"
    }
}

func getLocationId(_ query : String) throws -> Int {
    let json = try loadDataFromUrl("\(locationUrl)\(query)")
    if let array = json as? [Any] {
        if array.count>0 {
            if let location = array[0] as? [String : Any] {
                if let id = location["woeid"] as? Int {
                    return id
                } else {
                    throw "Invalid json object in location, no field woeid or not numeric"
                }
            } else {
                throw "Invalid json object in location array, expected: Object"
            }
        } else {
            throw "Location query \(query) yielded no result"
        }
    } else {
        throw "Invalid json object, expected: Array"
    }
}

struct WeatherInfo {
    let description : String
    let windDirection : String
    let date : Date
    let minTemp : Double
    let maxTemp : Double
    let windSpeed : Double
    let humidity : Int
    let probability : Int
    
    
}

func parseDate(_ string : String) throws -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat="yyyy-MM-dd"
    guard let date = dateFormatter.date(from: string) else {
        throw "Invalid date format: \(string)"
    }
    return date
}

extension WeatherInfo {
    init(_ jsonObject : Any) throws {
        if let jsonMap = jsonObject as? [String : Any] {
            guard let description = jsonMap["weather_state_name"] as? String,
                  let windDirection = jsonMap["wind_direction_compass"] as? String,
                  let dateStr = jsonMap["applicable_date"] as? String,
                  let minTemp = jsonMap["min_temp"] as? Double,
                  let maxTemp = jsonMap["max_temp"] as? Double,
                  let windSpeed = jsonMap["wind_speed"] as? Double,
                  let humidity = jsonMap["humidity"] as? Int,
                  let probability = jsonMap["predictability"] as? Int
                else {
                    throw "Invalid json object, did not find required fields or wrong datatypes (json: \(jsonObject))"
            }
            
            
            
            self.description = description
            self.windDirection = windDirection
            self.date = try parseDate(dateStr)
            self.minTemp = minTemp
            self.maxTemp = maxTemp
            self.windSpeed = windSpeed
            self.humidity = humidity
            self.probability = probability
        } else {
            throw "Invalid WeatherInfo object, expected: Object"
        }
    }
}

func getWeatherInfos(_ id : Int) throws -> [WeatherInfo] {
    let json = try loadDataFromUrl("\(weatherUrl)\(id)")
    var infos : [WeatherInfo] = []
    
    if let jsonObj = json as? [String : Any] {
        if let array = jsonObj["consolidated_weather"] as? [Any] {
            for info in array {
                try infos.append(WeatherInfo(info))
            }
            return infos
        } else {
            throw "Invalid consolidated_weather object, expected: Array"
        }
    } else {
        throw "Invalid weather info object, expected: Object"
    }
}

for query in queries {
    locationQueue.async {
        do {
            let id = try getLocationId(query)
            print("determined id \(id) for query \(query)")
            let infos = try getWeatherInfos(id)
            print(infos)
        }
        catch let err {
            print("Error: \(err)")
        }
        serialQueue.sync {
            queriesToComplete.remove(at: queriesToComplete.lastIndex(of: query)!)
        }
    }
}

func hasQueriesToComplete() -> Bool {
    var incomplete = true
    serialQueue.sync {
        incomplete = queriesToComplete.count>0
        if incomplete {
            print("Awaiting queries \(queriesToComplete) of \(queries)")
        }
    }
    return incomplete
}

while hasQueriesToComplete() {
    sleep(1)
}

print("All queries completed")


