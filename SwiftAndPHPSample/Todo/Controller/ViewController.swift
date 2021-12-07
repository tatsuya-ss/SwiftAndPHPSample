//
//  ViewController.swift
//  SwiftAndPHPSample
//
//  Created by 坂本龍哉 on 2021/12/07.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var todoLabel: UILabel!
    @IBOutlet private weak var deadlineLabel: UILabel!
    
    private let mySQLProtocol: MySQLProtocol = MySQL()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func didTapRefreshButton(_ sender: Any) {
        Task {
            do {
                let result = try await mySQLProtocol.fetch()
                todoLabel.text = result.todo
                deadlineLabel.text = result.deadline
                
            } catch {
                todoLabel.text = error.localizedDescription
            }
        }
    }
    
}

