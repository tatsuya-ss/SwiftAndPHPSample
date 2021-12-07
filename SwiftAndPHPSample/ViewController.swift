//
//  ViewController.swift
//  SwiftAndPHPSample
//
//  Created by 坂本龍哉 on 2021/12/07.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var displayLabel: UILabel!
    
    private let mySQLProtocol: MySQLProtocol = MySQL()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func didTapRefreshButton(_ sender: Any) {
        Task {
            do {
                let result = try await mySQLProtocol.fetch()
                displayLabel.text = result
            } catch {
                print(error)
            }
        }
    }
    
}

