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
    private let calendar = {
       var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()
    
    var inputCityID: Observable<Int> = Observable(1835847) //default: 서울
    var inputCountry: Observable<String> = Observable("KR")
    var inputState: Observable<String> = Observable("")
    
    var outputViewColor: Observable<UIColor> = Observable(.white)
    
    var outputForecastList: Observable<[ForecastInfo]> = Observable([])
    var outputHourList: Observable<[String]> = Observable([])
    var outputTempList: Observable<[String]> = Observable([])
    
//    var outputDailyList: Observable<[DailyInfo]> = Observable([])
    var outputDailyList: Observable<[[ForecastInfo]]> = Observable([])
    var outputWeekdayList: Observable<[String]> = Observable([])
    var outputMinMaxTempList: Observable<[(Int, Int)]> = Observable([])
    
    init() {
        transformData()
    }
}

extension WeatherViewModel {
    private func transformData() {
        inputCityID.bind { cityID in
            self.requestCurrentWeather(cityID)
            self.requestForecastWeather(cityID)
//            self.requestDailyWeather(cityID)
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
    
    private func requestForecastWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.forecast(cityID: id)) { (weather: ForecastWeather?) in
            guard let weather,!weather.list.isEmpty else { return }
            let infoList = weather.list
            self.appendWeekdayList(infoList)
            
//            var copyInfoList = infoList.map { weatherInfo in
//                var copy = weatherInfo
//                guard let date = self.convertDate(copy.dt_txt) else { return copy }
//                copy.dt_txt = String(date) //class, var로 변경하더라도 불가능한 시도
//                return copy
//            }
            
            infoList[self.threeDayRange].forEach { self.outputForecastList.value.append($0) }
            self.appendHourList(self.convertDate)
            self.appendTempList()
        }
    }
    
//    private func requestDailyWeather(_ id: Int) {
//        NetworkManager.requestAPI(APIRouter.daily(cityID: id)) { (weather: DailyWeather?) in
//            guard let weather, !weather.list.isEmpty else { return }
//            let infoList = weather.list
//            infoList.forEach { self.outputDailyList.value.append($0) }
//            self.appendWeekdayList()
//            self.appendMinMaxTempList()
//        }
//    }
}

extension WeatherViewModel {
    private func appendHourList(_ convertDate: (String) -> Date?) {
        outputForecastList.value.forEach {
            guard let date = convertDate($0.dt_txt) else { return }
            let hour = self.calendar.component(.hour, from: date)
            outputHourList.value.append("\(hour)시")
        }
    }
    
    private func appendTempList() {
        outputForecastList.value.forEach {
            let temp = $0.main.temp + inCelsius
            outputTempList.value.append("\(Int(temp))°")
        }
    }
    
    private func appendWeekdayList(_ weatherInfoList: [ForecastInfo]) {
        let maxLimit = 5
        var stringSet: Set<String> = []
        var sortedUniqueDateList: [Date] = []
        
        weatherInfoList.forEach {
            guard let date = self.convertDate($0.dt_txt) else { return }
            guard let timeInvalidatedDate = DateFormatter.convertDateFormat(date) else { return }
            let dateString = DateFormatter.dateToFormattedString(timeInvalidatedDate)
            stringSet.insert(dateString)
        }
        stringSet.forEach {
            guard let uniqueDate = DateFormatter.stringToDate($0) else { return }
            sortedUniqueDateList.append(uniqueDate)
            sortedUniqueDateList.sort()
        }
        sortedUniqueDateList.forEach {
            if self.outputWeekdayList.value.count < maxLimit {
                let weekday = DateFormatter.dateToWeekday($0)
                self.outputWeekdayList.value.append(weekday)
            }
        }
        print(outputWeekdayList.value)
    }
    
    private func appendMinMaxTempList() {
//        outputDailyList.value.forEach {
//            let (min, max) = ($0.temp.min, $0.temp.max)
//            outputMinMaxTempList.value.append((Int(min), Int(max)))
//        }
//        print(outputMinMaxTempList.value)
    }
}

extension WeatherViewModel {
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
