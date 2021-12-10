//
//  TodoTableViewCell.swift
//  SwiftAndPHPSample
//
//  Created by 坂本龍哉 on 2021/12/10.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {

    @IBOutlet private weak var todoLabel: UILabel!
    @IBOutlet private weak var deadlineLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(todo: Todo) {
        todoLabel.text = todo.todo
        deadlineLabel.text = todo.deadline + "まで"
    }
    
}
