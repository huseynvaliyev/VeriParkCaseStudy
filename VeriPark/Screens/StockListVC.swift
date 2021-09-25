//
//  StockListVC.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 24.09.2021.
//

import UIKit

protocol StockListViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class StockListVC: UIViewController {
    
    weak var delegate: StockListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "IMKB Hisse ve Endeksler"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}
