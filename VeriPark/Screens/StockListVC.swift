//
//  StockListVC.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 24.09.2021.
//

import UIKit
import CommonCrypto

protocol StockListViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}

class StockListVC: UIViewController {
    
    weak var delegate: StockListViewControllerDelegate?
    let defaults = UserDefaults.standard
    let period = "all"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "IMKB Hisse ve Endeksler"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
        
        guard let authorization = defaults.string(forKey: "Authorization") else { return }
        guard let key = defaults.string(forKey: "AESKey") else { return }
        guard let keyData = Data(base64Encoded: key) else { return }
        guard let iv = defaults.string(forKey: "AESIV") else { return }
        guard let ivData = Data(base64Encoded: iv) else { return }
        
        let aes = AES(key: keyData, iv: ivData)
        let data = aes?.encrypt(string: period)
        print(aes?.decrypt(data: data) ?? "")
        
        let str = String(decoding: data!, as: UTF8.self)
        let dataStr = str.toBase64()
        print("Data str: \(dataStr)")
        
        NetworkService.shared.getStockList(auth: authorization, period: dataStr) { result in
            switch result {
            case .success(let stocks):
                print("Stocks: \(stocks)")
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}
