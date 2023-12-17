//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Necati Alperen IŞIK on 14.12.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categories : Results<Category>!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
       
    }
    //MARK: - TableView Datasource Methods

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories"
               return cell
    }
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    //MARK: - Data Manipulation Method
    func save(category: Category){
        do{
            try realm.write{
                 realm.add(category)
            }
        }catch{
            print("error when saving categories")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    //MARK: - ADD NEW CATEGORİES

    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new cat", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "add a new category"
        }
        present(alert, animated: true,completion: nil)
    }
    
    
    
    
    
    
}
