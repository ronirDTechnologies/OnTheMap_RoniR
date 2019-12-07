//
//  StudentInfoTableViewCell.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 9/20/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import UIKit

class StudentInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var StudentCell: UIView!
    @IBOutlet weak var StudentNameLbl: UILabel!
    @IBOutlet weak var StudentUrlLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
