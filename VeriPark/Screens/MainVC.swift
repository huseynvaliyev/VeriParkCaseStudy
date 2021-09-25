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
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor = UIColor(named: "AccentColor")
        navigationController?.navigationBar.tintColor = .black
        configureLayout()
        let id = UIDevice.current.identifierForVendor?.uuidString
        let modelName = UIDevice.modelName
        let systemVersion = UIDevice.current.systemVersion
        guard let deviceId = id else { return }
        if defaults.string(forKey:"Authorization") == nil {
            NetworkService.shared.startWithHandshake(id: deviceId, systemVersion: systemVersion, modelName: modelName) { result in
                switch result {
                case .success(let data):
                    print("Data: \(data)")
                    self.defaults.set(data.authorization, forKey: "Authorization")
                    self.defaults.set(data.aesIV, forKey: "AESIV")
                    self.defaults.set(data.aesKey, forKey: "AESKey")
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc func pushStockListVC() {
        let stockListVC = ContainerVC()
        stockListVC.modalPresentationStyle = .fullScreen
        stockListVC.modalTransitionStyle = .flipHorizontal
        present(stockListVC, animated: true, completion: nil)
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
