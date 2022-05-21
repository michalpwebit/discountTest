//
//  CustomButton.swift
//  discountTest
//
//  Created by michal packter on 20/05/2022.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
         super.awakeFromNib()
         setTitleColor(UIColor.white, for: .normal)
         layer.cornerRadius = 6
         backgroundColor = UIColor.green     
 }

}
