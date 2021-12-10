//
//  ViewController.swift
//  SwiftAndPHPSample
//
//  Created by 坂本龍哉 on 2021/12/07.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var todoTextField: UITextField!
    @IBOutlet private weak var deadlineTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    private let mySQLProtocol: MySQLProtocol = MySQL()
    private var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    @IBAction private func didTapSaveButton(_ sender: Any) {
        saveToDo()
    }
    
    @IBAction private func didTapRefreshButton(_ sender: Any) {
        fetchToDo()
    }
    
}

// MARK: -
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
        cell.configure(todo: todos[indexPath.row])
        return cell
    }
    
}

// MARK: - func
extension ViewController {
    
    private func saveToDo() {
        guard let todo = todoTextField.text,
              let deadline = deadlineTextField.text,
              !todo.isEmpty,
              !deadline.isEmpty else { return }
        
        Task {
            do {
                try await mySQLProtocol.save(todo: todo, deadline: deadline)
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchToDo() {
        Task {
            do {
                let result = try await mySQLProtocol.fetch()
                todos = result
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(TodoTableViewCell.nib, forCellReuseIdentifier: TodoTableViewCell.identifier)
    }
}
