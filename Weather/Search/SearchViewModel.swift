//
//  SearchViewModel.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import UIKit

final class SearchViewModel {
    var viewColor: UIColor? = .white
    
    var inputLoadViewTrigger: Observable<Void?> = Observable(nil)
    var outputCityList: Observable<[City]> = Observable([])
    
    init() {
        transformData()
    }
}

extension SearchViewModel {
    private func transformData() {
        inputLoadViewTrigger.bind { _ in
            guard let cityList = JSONParser.fetchBundleDataParsedModel("CityList", to: [City].self) else { return }
            self.outputCityList.value = cityList
            print(self.outputCityList.value)
        }
    }
}
