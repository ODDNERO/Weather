//
//  WeatherViewModel.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import UIKit

final class WeatherViewModel {
    private var convertDate: (String) -> Date? = DateFormatter.convertKRDate
    private let inCelsius = -273.15
    private let threeDayRange = 0..<24
    
    var inputCityID: Observable<Int> = Observable(1835847) //default: 서울
    var inputCountry: Observable<String> = Observable("KR")
    var inputState: Observable<String> = Observable("")
    
    var outputViewColor: Observable<UIColor> = Observable(.white)
    
    var outputForecaseList: Observable<[ForecaseInfo]> = Observable([])
    var outputHourList: Observable<[String]> = Observable([])
    var outputTempList: Observable<[String]> = Observable([])
    
    init() {
        transformData()
    }
}

extension WeatherViewModel {
    private func transformData() {
        inputCityID.bind { cityID in
            self.requestCurrentWeather(cityID)
            self.requestForecaseWeather(cityID)
        }
        
        inputCountry.bind { country in
            guard let country = Country.convertCase(country) else { return }
            self.setupConvertDate(country)
        }
    }
}
 
extension WeatherViewModel {
    private func requestCurrentWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.current(cityID: id)) { (weather: CurrentWeather?) in
            guard let weather, let weatherInfo = weather.weather.first else {
                self.outputViewColor.value = .red
                return
            }
            guard let weatherCondition = WeatherCondition.convertCase(condition: weatherInfo.main) else { return }
            self.outputViewColor.value = weatherCondition.color
        }
    }
    
    private func requestForecaseWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.forecast(cityID: id)) { (weather: ForecaseWeather?) in
            guard let weather,!weather.list.isEmpty else { return }
            let infoList = weather.list
            
            infoList[self.threeDayRange].forEach { self.outputForecaseList.value.append($0) }
            self.appendHourList(self.convertDate)
            self.appendTempList()
        }
    }
}

extension WeatherViewModel {
    private func appendHourList(_ convertDate: (String) -> Date?) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        outputForecaseList.value.forEach {
            guard let date = convertDate($0.dt_txt) else { return }
            let hour = calendar.component(.hour, from: date)
            outputHourList.value.append("\(hour)시")
        }
    }
    
    private func appendTempList() {
        outputForecaseList.value.forEach {
            let temp = $0.main.temp + inCelsius
            outputTempList.value.append("\(Int(temp))°")
        }
    }
    
    private func setupConvertDate(_ country: Country) {
        switch country {
        case .KR:
            self.convertDate = DateFormatter.convertKRDate
        case .US:
            self.inputState.bind { state in
                guard let state = State.convertCase(state) else { return }
                switch state {
                case .TX:
                    self.convertDate = DateFormatter.convertTXDate
                case .CA:
                    self.convertDate = DateFormatter.convertCADate
                }
            }
        case .HK:
            self.convertDate = DateFormatter.convertHKDate
        case .JP:
            self.convertDate = DateFormatter.convertJPDate
        }
    }
}
