//
//  NameTableViewController.swift
//  Sort
//
//  Created by Cameron Milliken on 3/8/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import UIKit

class NameTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    @IBAction func AddPersonButtonTapped(_ sender: Any) {
        alertPopUp()
    }
    
    
    @IBAction func shuffleButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return GroupController.shared.groups.count    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = GroupController.shared.groups[indexPath.section]
        let person = group.personList[indexPath.row]
        cell.textLabel?.text = person
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = GroupController.shared.groups[indexPath.section]
            let personToDelete = group.personList[indexPath.row]
            GroupController.shared.deletePerson(person: personToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    



}//End of class

extension NameTableViewController {
    

func alertPopUp() {
    let alertController = UIAlertController(title: "Add A Name", message: nil, preferredStyle: .alert)
    alertController.addTextField { (textfield) in
        textfield.placeholder = "Enter A Name..."
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
        guard let newPerson = alertController.textFields?[0].text else { return }
        GroupController.shared.createPerson(person: newPerson)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(addAction)
    present(alertController, animated: true)
    }
}//End of extension

extension NameTableViewController {
    func shuffleGroups(personList: [String]) {
//        let shuffledGroup = personList.shuffle()
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffled() {
        let numCount = count
        guard numCount > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: numCount, to: 1, by: -1)) {
            
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    func shuffle() -> [Element] {
        var result = Array(self)
        result.shuffled()
        return result
    }
}
