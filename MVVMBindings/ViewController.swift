//
//  ViewController.swift
//  MVVMBindings
//
//  Created by Tim Akhm on 03.02.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    private var viewModel: ViewModelProtocol = ViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        viewModel.users.bind { [weak self] _ in
            print("VIEW viewModel.users.bind")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                print("VIEW viewModel.users.bind AFTER RELOAD")
            }
        }
        
        updateData()
    }
    
    func updateData() {
        print("VIEW updateData START")
        viewModel.getData { success in
            print("VIEW updateData")
            switch success {
            case true:
                print("Yeeeeee!")
            case false:
                print("Noooooo!")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.users.value[indexPath.row].name
        return cell
    }
}
