//
//  ContainerVC.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 25.09.2021.
//

import UIKit

class ContainerVC: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuVC()
    let stockListVC = StockListVC()
    var navVC: UINavigationController?
    lazy var gainersVC = GainersVC()
    lazy var losersVC = LosersVC()
    lazy var volume30VC = Volume30VC()
    lazy var volume50VC = Volume50VC()
    lazy var volume100VC = Volume100VC()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        addChildVCs()
    }
    
    private func addChildVCs() {
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        stockListVC.delegate = self
        let navVC = UINavigationController(rootViewController: stockListVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}

extension ContainerVC: StockListViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.stockListVC.view.frame.size.width - 80
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerVC: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuVC.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .stockList:
            self.reset()
        case .gainers:
            self.addGainers()
        case .losers:
            self.addLosers()
        case .volume30:
            self.addVolume30()
        case .volume50:
            self.addVolume50()
        case .volume100:
            self.addVolume100()
        }
    }
    
    func reset() {
        if let _ = stockListVC.children.first(where:{ $0 is GainersVC})  {
            gainersVC.view.removeFromSuperview()
            gainersVC.didMove(toParent: nil)
        }
        
        if let _ = stockListVC.children.first(where:{ $0 is LosersVC})  {
            losersVC.view.removeFromSuperview()
            losersVC.didMove(toParent: nil)
        }
        
        if let _ = stockListVC.children.first(where:{ $0 is Volume30VC})  {
            volume30VC.view.removeFromSuperview()
            volume30VC.didMove(toParent: nil)
        }
        
        if let _ = stockListVC.children.first(where:{ $0 is Volume50VC})  {
            volume50VC.view.removeFromSuperview()
            volume50VC.didMove(toParent: nil)
        }
        
        if let _ = stockListVC.children.first(where:{ $0 is Volume100VC})  {
            volume100VC.view.removeFromSuperview()
            volume100VC.didMove(toParent: nil)
        }
        stockListVC.title = "IMKB Hisse ve Endeksler"
    }
    
    func addGainers() {
        let vc = gainersVC
        stockListVC.addChild(vc)
        stockListVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: stockListVC)
        stockListVC.title = vc.title
    }
    
    func addLosers() {
        let vc = losersVC
        stockListVC.addChild(vc)
        stockListVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: stockListVC)
        stockListVC.title = vc.title
    }
    
    func addVolume30() {
        let vc = volume30VC
        stockListVC.addChild(vc)
        stockListVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: stockListVC)
        stockListVC.title = vc.title
    }
    
    func addVolume50() {
        let vc = volume50VC
        stockListVC.addChild(vc)
        stockListVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: stockListVC)
        stockListVC.title = vc.title
    }
    
    func addVolume100() {
        let vc = volume100VC
        stockListVC.addChild(vc)
        stockListVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: stockListVC)
        stockListVC.title = vc.title
    }
}
