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
        inputCityID.bind { [weak self] cityID in
            guard let self else { return }
            self.requestCurrentWeather(cityID)
            self.requestForecastWeather(cityID)
//            self.requestDailyWeather(cityID)
        }
        
        inputCountry.bind { [weak self] country in
            guard let country = Country.convertCase(country) else { return }
            self?.setupConvertDate(country)
        }
    }
}

extension WeatherViewModel {
    private func requestCurrentWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.current(cityID: id)) { [weak self] (response: Result<CurrentWeather, Error>) in
            guard let self else { return }
            switch response {
            case .success(let data):
                guard let weatherInfo = data.weather.first else { return }
                guard let weatherCondition = WeatherCondition.convertCase(condition: weatherInfo.main) else { return }
                self.outputViewColor.value = weatherCondition.color
            case .failure(let error):
                self.outputViewColor.value = .red
                print(">>>>> Current API Failure \n\(error) \n<<<<<")
            }
        }
    }
    
    private func requestForecastWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.forecast(cityID: id)) { [weak self] (response: Result<ForecastWeather, Error>) in
            guard let self else { return }
            switch response {
            case .success(let data):
                guard !data.list.isEmpty else { return }
                let weatherList = data.list
                self.appendWeekdayList(weatherList)
                weatherList[self.threeDayRange].forEach { self.outputForecastList.value.append($0) }
                self.appendHourList(self.convertDate)
                self.appendTempList()
            case .failure(let error):
                self.outputViewColor.value = .red
                print(">>>>> Forecast API failure \n\(error) \n<<<<<")
            }
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
            let hour = calendar.component(.hour, from: date)
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
        var weekdayList = [String]()
        let maxLimit = 5
        weatherInfoList.forEach {
            guard let date = convertDate($0.dt_txt) else { return }
            let weekday = DateFormatter.dateToWeekday(date)
            if !(weekdayList.contains(weekday)) && (weekdayList.count < maxLimit) {
                weekdayList.append(weekday)
            }
        }
        weekdayList[0] = "오늘"
        outputWeekdayList.value = weekdayList
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
            convertDate = DateFormatter.convertKRDate
        case .US:
            inputState.bind { [weak self] state in
                guard let state = State.convertCase(state) else { return }
                switch state {
                case .TX:
                    self?.convertDate = DateFormatter.convertTXDate
                case .CA:
                    self?.convertDate = DateFormatter.convertCADate
                }
            }
        case .HK:
            self.convertDate = DateFormatter.convertHKDate
        case .JP:
            self.convertDate = DateFormatter.convertJPDate
        }
    }
}
