//
//  BaseViewController.swift
//  Weather
//
//  Created by NERO on 7/10/24.
//

import UIKit

class BaseViewController<ContentView: UIView, ViewModel>: UIViewController {
    let contentView = ContentView()
    var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEventHandler()
        setupDelegate()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        setupToolBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
    }
    func setupToolBar() {
        let appearance = UIToolbarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = contentView.backgroundColor?.withAlphaComponent(0.8) //임시
        appearance.shadowColor = .white.withAlphaComponent(0.5)
        navigationController?.toolbar.scrollEdgeAppearance = appearance
        navigationController?.toolbar.standardAppearance = appearance
        navigationController?.toolbar.tintColor = .white
        navigationController?.isToolbarHidden = false
    }
    
    func addEventHandler() {}
    func setupDelegate() {}
    func bindViewModel() {}
}
