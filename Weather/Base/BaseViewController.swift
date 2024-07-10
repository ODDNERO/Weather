//
//  BaseViewController.swift
//  Weather
//
//  Created by NERO on 7/10/24.
//

import UIKit

class BaseViewController<ContentView: UIView>: UIViewController {
    let contentView = ContentView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addEventHandler()
        setupDelegate()
        bindData()
    }
    
    func setupNavigationBar() {}
    func addEventHandler() {}
    func setupDelegate() {}
    func bindData() {}
}
