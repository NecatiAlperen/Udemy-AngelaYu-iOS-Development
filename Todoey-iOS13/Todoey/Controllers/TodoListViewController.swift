//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{

    
        
    var todoItems : Results<Item>?
    let realm = try! Realm()
    var selectedCategory :Category? {
        didSet{
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
         
    
    }
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "no items added"
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write{
                    item.done = !item.done
                }
            }catch{
                print("error saving done status")
            }
            tableView.reloadData()
            
        }

        
    }
    
    // MARK- Add New Items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            // what will happen once the user clisck add item
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("error saving new items")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "enter new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    

    
    
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
    }

    
}


extension TodoListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
