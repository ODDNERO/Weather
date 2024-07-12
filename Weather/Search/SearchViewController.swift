//
//  SearchViewController.swift
//  Weather
//
//  Created by NERO on 7/12/24.
//

import UIKit

final class SearchViewController: BaseViewController<SearchView> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.contentView.setupBackgroundColor()
    }
}
