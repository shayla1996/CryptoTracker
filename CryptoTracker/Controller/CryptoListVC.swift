//
//  CryptoListVC.swift
//  CryptoTracker
//
//  Created by Shaikat on 29/5/21.
//  Copyright © 2021 Shayla.18. All rights reserved.
//

import UIKit

class CryptoListVC: UIViewController {
    
    var viewModels : [CryptoTableviewCellViewModel] = []
    
    private let numberFormater : NumberFormatter = {
       let formater = NumberFormatter()
        formater.allowsFloats = true
        formater.locale = .current
        formater.numberStyle = .currency
        return formater
    }()

    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(UINib(nibName: CryptoTableviewCell.id, bundle: nil), forCellReuseIdentifier: CryptoTableviewCell.id)
            tableview.rowHeight = UITableView.automaticDimension
            tableview.separatorStyle = .none
        }
    }
    
    var iconString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        CryptoAPIService.shared.getAllAssets { (result) in
            switch result {
            case .success(let cryptoArray):
                for cryptoModel in cryptoArray {
                    let price = cryptoModel.price_usd
                    let priceString = self.numberFormater.string(from: NSNumber(value: Float(price ?? 0.00))) ?? ""
                    
                    let icons = CryptoAPIService.shared.icons
                    for each in icons {
                        if each.asset_id == cryptoModel.asset_id {
                            self.iconString = each.url
                        }
                    }
                    let viewmodel = CryptoTableviewCellViewModel(
                        tit: cryptoModel.name ?? "",
                        sym: cryptoModel.asset_id,
                        pri: priceString,
                        icon: URL(string: self.iconString))
                    self.viewModels.append(viewmodel)
                    DispatchQueue.main.async{
                        self.tableview.reloadData()
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension CryptoListVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableviewCell.id, for: indexPath) as? CryptoTableviewCell {
            cell.config(model: viewModels[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    
}
