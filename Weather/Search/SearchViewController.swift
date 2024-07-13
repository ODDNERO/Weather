//
//  SearchViewController.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import UIKit

final class SearchViewController: BaseViewController<SearchView, SearchViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIBox.Icon.back, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.rightBarButtonItem = setupMenuButton()
    }
    
    override func setupToolBar() {
        navigationController?.toolbar.isHidden = true
    }
    
    override func bindViewModel() {
        self.contentView.setupBackgroundColor(self.viewModel.viewColor!)
    }
}

extension SearchViewController {
    @objc private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupMenuButton() -> UIBarButtonItem {
        let oneAction = UIAction(title: "임시 1", image: nil) { _ in
            //
        }
        let twoAction = UIAction(title: "임시 2", image: nil) { _ in
            //
        }
        let menu = UIMenu(children: [oneAction, twoAction])
        let menuButton = UIBarButtonItem(title: nil, image: UIBox.Icon.menu, target: nil, action: nil, menu: menu)
        return menuButton
    }
}
