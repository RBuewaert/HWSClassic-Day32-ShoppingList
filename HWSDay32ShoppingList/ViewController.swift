//
//  ViewController.swift
//  Project6M-Milestone
//
//  Created by Romain Buewaert on 28/09/2021.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Your shopping list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Remove All", style: .done, target: self, action: #selector(removeList))

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        toolbarItems = [spacer, shareButton]
        navigationController?.isToolbarHidden = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)

        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = shoppingList[indexPath.row]
        cell.contentConfiguration = contentConfig

        return cell
    }

    @objc func addItem() {
        let ac = UIAlertController(title: "Enter an item", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }

            self?.shoppingList.insert(answer, at: 0)

            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    @objc func removeList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }

    @objc func shareList() {
        let list = shoppingList.joined(separator: "\n")

        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
