//
//  ViewController.swift
//  Wheather
//
//  Created by Александр Ляхов on 14.09.2021.
//

//
//  ViewController.swift
//  new app
//
//  Created by Александр Ляхов on 09.09.2021.
//

import UIKit
import Foundation
import CoreLocation
import Alamofire

class ViewController: UIViewController{
    @IBOutlet weak var picker: UIPickerView!
    
}
// MARK: - Wheather View
class Wheather: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var lblWheatherSummary: UILabel!
    @IBOutlet weak var City: UILabel!
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
                      self.lblWheatherSummary.text = main
                  }
                  if let description = weather[0]["description"] as? String {
                      print("description=\(description)")
                      self.lblWheatherSummary.text = "\(self.lblWheatherSummary.text!), \(description)"
                  }
              }

              if let main = json["main"] as? [String:Any]   {
                  if let temp = main["temp"] as? NSNumber {
                      print("temp=\(temp)")
                      self.lblWheatherSummary.text = "\(temp) \(self.unit)"
                  }
                  if let temp_max = main["temp_max"] as? NSNumber, let temp_min = main["temp_min"] as? NSNumber {
                      print("temp_max=\(temp_max) and temp_min=\(temp_min)")
                  }
              }
              if let name = json["name"] as? String  {
                  print("name=\(name)")
                  self.City.text = name
              }

          }

      }
    }
    
    
    @IBOutlet weak var currentData: UILabel!

    @IBOutlet weak var StyleViewWheather: UIView!
    override func viewDidLoad() {
        loadCurrentWeather();
        let today = Date()
        let d_format = DateFormatter()
        let m_format = DateFormatter()
        m_format.dateFormat = "MM"
        d_format.dateFormat = "dd"
        currentData.text = "Сегодня " + d_format.string(from: today) + " Месяц " + m_format.string(from: today)
        // MARK: - Style Button Wheather View
        StyleViewWheather.layer.shadowColor = UIColor.black.cgColor
        StyleViewWheather.layer.shadowOpacity = 1
        StyleViewWheather.layer.shadowOffset = .zero
        StyleViewWheather.layer.shadowRadius = 5
        StyleViewWheather.layer.cornerRadius = 30
        
    }
}
// MARK: - Settings View
class Settings: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // Submit button
    @IBOutlet weak var ButtonSubVar: UIButton!
    // MARK: Picker City
    @IBOutlet weak var PickerCity: UIPickerView!
    var pickerData: [String] = [String]()

    // TODO: Create piker storage
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return pickerData.count
       }
      public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           print(pickerData[row])
           return pickerData[row]
       }
    // MARK: Btn Sub Alert
    @IBAction func SubButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: " Применить Смену погоды?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonSubVar.layer.cornerRadius = 5
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.PickerCity.delegate = self
        self.PickerCity.dataSource = self
        
        // Input the data into the array
        pickerData = ["Moscow", "Saint Petersburg"]
    }

}

