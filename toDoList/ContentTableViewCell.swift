//
//  ContentTableViewCell.swift
//  toDoList
//
//  Created by TALHA AYAR on 23.09.2018.
//  Copyright © 2018 TALHA AYAR. All rights reserved.
//

import UIKit
import UICheckbox_Swift


class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    

    
    
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var checkBox: UICheckbox!

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 15;
        
        checkBox.onSelectStateChanged = { (checkbox, selected) in
            if (selected) {
                 self.contentName.textColor = UIColor.darkGray
                let attributedString = NSMutableAttributedString(string: self.contentName.text!)
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
                self.contentName.attributedText = attributedString
                self.dateLabel.textColor = UIColor.darkGray
                let AttributedString = NSMutableAttributedString(string: self.dateLabel.text!)
                AttributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, AttributedString.length))
                self.dateLabel.attributedText = AttributedString
            } else {
                 self.contentName.textColor = UIColor.black
                let attributedString = NSMutableAttributedString(string: self.contentName.text!)
                attributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, 5))
                 self.contentName.attributedText = attributedString
                self.dateLabel.textColor = UIColor.black
                let AttributedString = NSMutableAttributedString(string: self.dateLabel.text!)
                AttributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, 5))
                self.dateLabel.attributedText = AttributedString
            }
        }
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    @IBAction func confirmButton(_ sender: Any) {
        
    }
}
