//
//  WeatherViewModel.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import UIKit

final class WeatherViewModel {
    var inputCityID: Observable<Int> = Observable(1835847) //default: 서울
    var outputViewColor: Observable<UIColor> = Observable(.white)
    
    var forecaseList: [ForecaseInfo] = []
    private let inCelsius = -273.15
    private let threeDayRange = 0..<24
    
    var outputForecaseTimeList: Observable<[String]> = Observable([])
    
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
    }
    
    private func requestCurrentWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.current(cityID: id)) { (weather: CurrentWeather?) in
            if let weather, let weatherInfo = weather.weather.first,
               let weatherCondition = WeatherCondition.convertCase(condition: weatherInfo.main) {
                self.outputViewColor.value = weatherCondition.color
                print("\(weather.name) 현재 온도: \(weather.main.temp + self.inCelsius)°C \n")
            } else {
                self.outputViewColor.value = .red
//                print(weather, "\n")
            }
        }
    }
    
    private func requestForecaseWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.forecast(cityID: id)) { (weather: ForecaseWeather?) in
            guard let weather else { return }
            guard !weather.list.isEmpty else { return }
            var infoList = weather.list
//            print(infoList)
            
            infoList[self.threeDayRange].forEach { self.forecaseList.append($0) }
            print(self.forecaseList)
            self.convertDate()
        }
    }
}

extension WeatherViewModel {
//    func convertKRDate(_ date: String) -> (Date?, Calendar?) {
    func convertKRDate(_ date: String) -> Date? {
        let formatter = DateFormatter()
//        dateFormat.locale = Locale(identifier: "ko_KR")
//        formatter.timeZone = TimeZone(abbreviation: "KST")
//        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
//        guard let UTCDate = formatter.date(from: date) else { return (nil, nil) }
        guard let UTCDate = formatter.date(from: date) else { return nil }
        
//        var calendar = Calendar.current
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
//        guard let KRDate = calendar.date(byAdding: .hour, value: 9, to: UTCDate) else { return (nil, nil) }
//        guard let KRDate = calendar.date(byAdding: .hour, value: 9, to: UTCDate) else { return nil }
        
        let KSTTimeZone = TimeZone(identifier: "Asia/Seoul")!
        let KSTSeconds = KSTTimeZone.secondsFromGMT(for: UTCDate)
        let KRDate = UTCDate.addingTimeInterval(TimeInterval(KSTSeconds))
//        return (UTCDate, calendar)
        return KRDate
    }
    
    private func convertDate() {
//        let calendar = Calendar.current
        var calendar = Calendar(identifier: .gregorian)
//            calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        forecaseList.forEach {
//            print($0.dt_txt, $0.main.temp - 273.15)
//            guard let date = WeatherViewModel.KRFormatter.date(from: $0.dt_txt) else { return }
            
//            let (KRDate, KRCalender) = convertKRDate($0.dt_txt)
//            guard let KRDate, let KRCalender else { return }
            guard let KRDate = convertKRDate($0.dt_txt) else { return }
            print(KRDate, $0.main.temp + inCelsius)
            
//            let hour = Calendar.current.component(.hour, from: KRDate)
//            let hour = KRCalender.component(.hour, from: KRDate)
//            let hour = Calendar(identifier: .gregorian).component(.hour, from: KRDate)
            
            let hour = calendar.component(.hour, from: KRDate)
            outputForecaseTimeList.value.append("\(hour)시")
            
            let temp = $0.main.temp + inCelsius //print 확인용
//            print("\(hour + 9)시: \(Int(temp))°C")
            print("\(hour)시: \(Int(temp))°C")
        }
        print(outputForecaseTimeList.value)
    }
}
