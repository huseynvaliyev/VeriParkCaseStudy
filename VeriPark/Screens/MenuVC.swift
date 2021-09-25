//
//  MenuVC.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 25.09.2021.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuVC.MenuOptions)
}

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOptions: String, CaseIterable {
        case stockList = "Hisse ve Endekler"
        case gainers = "Yükselenler"
        case losers = "Düşenler"
        case volume30 = "Hacme Göre - 30"
        case volume50 = "Hacme Göre - 50"
        case volume100 = "Hacme Göre - 100"
        
        var imageName: String {
            switch self {
            case .stockList:
                return "chart.bar.xaxis"
            case .gainers:
                return "arrow.up.square.fill"
            case .losers:
                return "arrow.down.square.fill"
            case .volume30:
                return "30.square.fill"
            case .volume50:
                return "50.square.fill"
            case .volume100:
                return "10.square.fill"
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemGray6
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.backgroundColor = .systemGray6
        cell.contentView.backgroundColor = .systemGray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }

}
