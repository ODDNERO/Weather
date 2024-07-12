//
//  ViewController.swift
//  Weather
//
//  Created by NERO on 7/10/24.
//

import UIKit

final class WeatherViewController: BaseViewController<WeatherView> {
    
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
}

extension WeatherViewController {
    func setupToolBarButtons() -> [UIBarButtonItem] {
        let mapButton = UIBarButtonItem(image: UIBox.Icon.map, style: .plain, target: self, action: nil) //action 추가 필요
        let listButton = UIBarButtonItem(image: UIBox.Icon.list, style: .plain, target: self, action: #selector(listButtonClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return [mapButton, flexibleSpace, listButton]
    }
    
    @objc private func listButtonClicked() {
        let searchVC = SearchViewController()
        searchVC.contentView.viewColor = self.contentView.backgroundColor //임시
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
