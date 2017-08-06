//
//  HomeViewController.swift
//  DependencyInjection
//
//  Created by Bherly Novrandy on 8/3/17.
//  Copyright © 2017 Bherly. All rights reserved.
//

import UIKit

protocol IHomeView: class {
    func showJoke(joke: String)
    func showError(error: NSError?)
}

class HomeViewController: UIViewController {

    var presenter: IHomePresenter!
    
    @IBOutlet weak var labelJoke: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getAJoke(_ sender: UIButton) {
        presenter.jokes()
    }
    @IBAction func goToDetails(_ sender: UIButton) {
        presenter.details()
    }
}

extension HomeViewController: IHomeView {
    func showJoke(joke: String) {
        labelJoke.text = joke
    }
    
    func showError(error: NSError?) {
        
    }
}
