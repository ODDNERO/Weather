//
//  ViewController.swift
//  Weather
//
//  Created by NERO on 7/10/24.
//

import UIKit

final class WeatherViewController: BaseViewController<WeatherView, WeatherViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.isHidden = true
    }
    override func setupToolBar() {
        super.setupToolBar()
        navigationController?.toolbar.isHidden = false
        setToolbarItems(setupToolBarButtons(), animated: true)
    }
    
    override func bindViewModel() {
        self.viewModel.outputViewColor.bind { color in
            self.contentView.setupBackgroundColor(color)
        }
    }
}

extension WeatherViewController {
    private func setupToolBarButtons() -> [UIBarButtonItem] {
        let mapButton = UIBarButtonItem(image: UIBox.Icon.map, style: .plain, target: self, action: nil) //action 추가 필요
        let listButton = UIBarButtonItem(image: UIBox.Icon.list, style: .plain, target: self, action: #selector(listButtonClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return [mapButton, flexibleSpace, listButton]
    }
    
    @objc private func listButtonClicked() {
        let searchVC = SearchViewController(viewModel: SearchViewModel())
        searchVC.viewModel.viewColor = self.contentView.backgroundColor //임시
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
