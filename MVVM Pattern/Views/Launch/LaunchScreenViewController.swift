//
//  LaunchScreenViewController.swift
//  MVVM Pattern
//
//  Created by Ehtisham Badar on 30/07/2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToHome()
    }
    func navigateToHome(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            let vc = MovieListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
