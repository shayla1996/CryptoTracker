//
//  CryptoTableviewCell.swift
//  CryptoTracker
//
//  Created by Shaikat on 29/5/21.
//  Copyright © 2021 Shayla.18. All rights reserved.
//

import UIKit

class CryptoTableviewCellViewModel {
    let title : String
    let symbol : String
    let price : String
    let iconurl : URL?
    
    init(tit : String ,
         sym : String ,
         pri : String,
         icon : URL?) {
        self.title = tit
        self.symbol = sym
        self.price = pri
        self.iconurl = icon
    }
}

class CryptoTableviewCell: UITableViewCell {
    
    static let id = "CryptoTableviewCell"

    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewOutlet.image = nil
        titleLbl.text = nil
        symbolLbl.text = nil
        priceLbl.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func config(model : CryptoTableviewCellViewModel) {
        titleLbl.text = model.title
        symbolLbl.text = model.symbol
        priceLbl.text = model.price
        
        if let url = model.iconurl {
            let urlSession = URLSession.shared
            let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageViewOutlet.image = UIImage(data: data)
                    }
                }
            }
            dataTask.resume()
        }
        
    }
}
