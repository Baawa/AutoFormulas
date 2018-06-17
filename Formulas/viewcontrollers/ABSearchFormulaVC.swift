//
//  ABSearchFormulaVC.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-08.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

class ABSearchFormulaVC: UITableViewController, UISearchResultsUpdating {
	internal var searchController:UISearchController!
	internal let reuseId:String = "cell"
	
	internal var data:[ABFormula] = ABFormulasCollection.sorted()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.title = "Formulas"
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.register(ABSearchTVC.self, forCellReuseIdentifier: reuseId)
		
		searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search formulas.."
		searchController.searchBar.tintColor = .white
		searchController.searchBar.setSearchFieldBackgroundImage(#imageLiteral(resourceName: "searchBarBg"), for: .normal)
		definesPresentationContext = true
		//refreshControl = UIRefreshControl()
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		
		updateTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: UISearchController
	func updateSearchResults(for searchController: UISearchController) {
		let searchText = searchController.searchBar.text!.lowercased()
		
		if searchText != ""{
			self.data = ABFormulasCollection.search(searchText)
		} else{
			self.data = ABFormulasCollection.sorted()
		}
		
		updateTableView()
	}
	
	internal var cells:[ABSearchTVC] = []
	func updateTableView(){
		DispatchQueue.main.async {
			self.cells.removeAll()
			for item in self.data{
				var cell = self.tableView.dequeueReusableCell(withIdentifier: self.reuseId) as! ABSearchTVC
				cell.textLabel?.text = item.name
				cell.selectionStyle = .none
				
				let margin:CGFloat = 20
				/*let size:CGFloat = 25
				var icon = UIImageView(frame: CGRect(x: self.view.frame.width-size-margin, y: cell!.frame.height/2 - size/2, width: size, height: size))
				icon.image = data[indexPath.row].getIcon()
				cell?.addSubview(icon)*/
				
				let tc = item.getTypeAndColor()
				
				var size = ABTagView.recommendedSize(str: tc.0)
				
				cell.tagView = ABTagView(frame: CGRect(x: self.view.frame.width-size.width-margin, y: cell.frame.height/2 - size.height/2, width: size.width, height: size.height), tag: tc.0, bg: tc.1)
				
				self.cells.append(cell)
			}
			self.tableView.reloadData()
		}
	}
	
	// MARK: - Segues
	internal let convSegue = "showConversion"
	internal let formulaSegue = "showFormula"
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == formulaSegue{
			if let indexPath = tableView.indexPathForSelectedRow {
				let controller = segue.destination as! ABFormulaVC
				controller.navbarHeight = 96 + 20//self.navigationController!.navigationBar.frame.height + self.navigationController!.navigationBar.frame.origin.y
				controller.formula = self.data[tableView.indexPathForSelectedRow!.row]
			}
		} else if segue.identifier == convSegue{
			if let indexPath = tableView.indexPathForSelectedRow {
				let controller = segue.destination as! ABConversionVC
				controller.navbarHeight = 96 + 20//self.navigationController!.navigationBar.frame.height + self.navigationController!.navigationBar.frame.origin.y
				controller.formula = self.data[tableView.indexPathForSelectedRow!.row] as! ABConversionFormula
			}
		}
		
		/*if segue.identifier == "showDetail" {
			if let indexPath = tableView.indexPathForSelectedRow {
				let candy = candies[indexPath.row]
				let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
				controller.detailCandy = candy
				controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		}*/
	}
    
	// MARK: UITableView
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let formula = self.data[indexPath.row]
		if formula.type == .conversion{
			self.performSegue(withIdentifier: convSegue, sender: self)
		} else{
			self.performSegue(withIdentifier: formulaSegue, sender: self)
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cells.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cells[indexPath.row]
	}

}
