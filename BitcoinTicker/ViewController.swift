//
//  ViewController.swift
//  BitcoinTicker

//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{

    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbollArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1  // number of column
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL = baseURL + currencyArray[row]
        getCoinData(url : finalURL,CurrencyPos : row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       currencyPicker.delegate = self
       currencyPicker.dataSource = self
        
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    
    

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
    
    func getCoinData(url: String, CurrencyPos : Int) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the Coin data")
                    let coinJSON : JSON = JSON(response.result.value!)

                    print(coinJSON)
                    self.updateCoinData(json: coinJSON,pos : CurrencyPos)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

//
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateCoinData(json : JSON, pos : Int) {
        
        if let coinResult = json["ask"].double {
        bitcoinPriceLabel.text = currencySymbollArray[pos] + String(coinResult)
//        weatherData.temperature = Int(round(tempResult!) - 273.15)
//        weatherData.city = json["name"].stringValue
//        weatherData.condition = json["weather"][0]["id"].intValue
//        weatherData.weatherIconName =    weatherData.updateWeatherIcon(condition: weatherData.condition)
        }
        
//        updateUIWithWeatherData()
    }
//




}

