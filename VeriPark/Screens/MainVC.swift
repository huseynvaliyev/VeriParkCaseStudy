//
//  MainVC.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 24.09.2021.
//

import UIKit

class MainVC: UIViewController {
    
    let logoImageView = UIImageView()
    let textLabel = UILabel()
    let actionButton = VPButton(backgroundColor: .systemGray4, title: "IMKB Hisse Senetleri/Endeksler")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor = UIColor(named: "AccentColor")
        navigationController?.navigationBar.tintColor = .black
        configureLayout()
    }
    
    @objc func pushStockListVC() {
        let stockListVC = StockListVC()
        navigationController?.pushViewController(stockListVC, animated: true)
    }
    
    private func configureLayout() {
        logoImageView.image = UIImage(named: "veripark")
        
        textLabel.text = "VERİPARK"
        textLabel.font = UIFont.systemFont(ofSize: 24)
        textLabel.textColor = .systemGray
        
        actionButton.addTarget(self, action: #selector(pushStockListVC), for: .touchUpInside)
        
        let topStackView = UIStackView(arrangedSubviews: [
            logoImageView, textLabel
        ])
        let mainStackView = UIStackView(arrangedSubviews: [
            topStackView, actionButton
        ])
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            actionButton.heightAnchor.constraint(equalToConstant: 38),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
