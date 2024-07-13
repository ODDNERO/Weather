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
                print(weather, "\n")
            } else {
                self.outputViewColor.value = .red
                print(weather, "\n")
            }
        }
    }
    
    private func requestForecaseWeather(_ id: Int) {
        NetworkManager.requestAPI(APIRouter.forecast(cityID: id)) { (weather: ForecaseWeather?) in
            if let weather, let weatherInfo = weather.list.first {
                print(">>>>>", Date())
                print(weather)
            }
        }
    }
}
