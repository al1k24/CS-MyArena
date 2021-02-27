//
//  ServerInfoTableViewCell.swift
//  CS-MyArena
//
//  Created by Алик on 27.02.2021.
//

import UIKit

class ServerInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setupBlurEffectForMapImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        setupBlurEffectForMapImage()
//    }
    
    private func setupBlurEffectForMapImage() {
        let darkBlur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = mapImage.bounds
        blurView.alpha = 0.7
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapImage.addSubview(blurView)
    }
    
}

extension ServerInfoTableViewCell: NibLoadable {}
