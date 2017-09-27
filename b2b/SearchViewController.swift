//
//  ViewController.swift
//  b2b
//
//  Created by if65 on 27/09/2017.
//  Copyright © 2017 if65. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        let cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
        
        searchBar.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
}

var searchResults = [SearchResult]()

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        searchResults = []
        for _ in 0...2 {
            let searchResult = SearchResult()
            
            searchResult.codiceGcc = "0205055161"
            searchResult.codiceSm = "0427318"
            searchResult.descrizione = "LAVATRICE CF 8KG 1200G A+++ DISP BIG"
            searchResult.modello = "WAK24268IT"
            searchResult.marchio = "BOSCH"
            
            searchResults.append(searchResult)
        }
        tableView.reloadData()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        cell.codiceGcc.text = searchResults[indexPath.row].codiceGcc
        cell.codiceSM.text = searchResults[indexPath.row].codiceSm
        cell.descrizione.text = searchResults[indexPath.row].descrizione
        cell.marchio.text = searchResults[indexPath.row].marchio
        cell.modello.text = searchResults[indexPath.row].modello
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

