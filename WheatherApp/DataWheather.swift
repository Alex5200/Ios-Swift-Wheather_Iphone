//
//  dataWheather.swift
//  Wheather
//
//  Created by Александр Ляхов on 15.09.2021.
//

import Foundation
import Foundation
import CoreLocation
import Alamofire


class DataWheather {
    struct defaultsKeys {
        static var tempW: Int = 0
    }

    let APIKEY = "f765a62486dd5839cfc0051699c8d603"
    let BASEURL = "https://api.openweathermap.org/data/2.5/"
    let WEATHER = "weather?"
    var lat =  "Moscow"
    var lng = 0.0
    var units = "metric"
    var unit = "C"
    var locationManager = CLLocationManager()

    func loadCurrentWeather() {
    let url = "\(BASEURL)\(WEATHER)q=\(lat)&appid=\(APIKEY)&units=\(units)"
      Alamofire.request(url).responseJSON { response in
          if let json = response.result.value as? [String: Any] {
              if let weather = json["weather"] as? [[String:Any]]   {
                  if let main = weather[0]["main"] as? String {
                      print("main=\(main)")
                  }
                  if let description = weather[0]["description"] as? String {
                      print("description=\(description)")
                      
                  }
              }

              if let main = json["main"] as? [String:Any]   {
                  if let temp = main["temp"] as? NSNumber {
                      print("temp=\(temp)")
                    defaultsKeys.tempW = Int(temp)
                  
                  }
                  if let temp_max = main["temp_max"] as? NSNumber, let temp_min = main["temp_min"] as? NSNumber {
                      print("temp_max=\(temp_max) and temp_min=\(temp_min)")
                  }
              }
              if let name = json["name"] as? String  {
                  print("name=\(name)")
              }

          }

      }
    }
}
