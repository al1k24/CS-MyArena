//
//  ServersListTableViewCell.swift
//  CS-MyArena
//
//  Created by Алик on 18.02.2021.
//

import UIKit

class ServersListTableViewCell: UITableViewCell {
    
    deinit { print("* deinit -> ServersListTableViewCell") }
    
//    @IBOutlet private weak var mapImage: UIImage!
    @IBOutlet private weak var serverLabel: UILabel!
    @IBOutlet private weak var ipLabel: UILabel!
    @IBOutlet private weak var mapLabel: UILabel!
    @IBOutlet private weak var onlineLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Server) {
        serverLabel.text = model.name
        ipLabel.text = "IP: \(model.ip)"
        mapLabel.text = "Map: \(model.map)"
        onlineLabel.text = "Online: \(model.playersOnline)/\(model.totalPlayers)"
    }
    
}

extension ServersListTableViewCell: NibLoadable {}
