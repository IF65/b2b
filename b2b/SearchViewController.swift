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
    
        // MARK:- Private Methods
    func iTunesURL(searchText: String) -> URL {
        let urlString = String(format:"http://10.11.14.78/copre/copre.php?functionName=tabulatoCopre2&ediel01=&ediel02=&ediel03=&ediel04=&marchio=&descrizione=%@&codiceArticolo=&barcode=&modello=", searchText)
        let url = URL(string: urlString)
        return url!
    }
    
    func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Download error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func parse(data: Data) -> ResultArray? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            print(result.resultCount)
            return result
        } catch {
            print("JSON Error \(error)")
            return nil
        }
    }
}

var searchResults = ResultArray()

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            
            searchBar.resignFirstResponder()
            
            let url = iTunesURL(searchText: searchBar.text!)
            print ("URL: '\(url)'")
            
            if let data = performStoreRequest(with: url) {
                searchResults = parse(data: data)!
                
                //print ("Got results : '\(searchResults.results[0].descrizione)'")
            }
            
            tableView.reloadData()
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        cell.codiceGcc.text = searchResults.results[indexPath.row].codice
        cell.descrizione.text = searchResults.results[indexPath.row].descrizione
        cell.marchio.text = searchResults.results[indexPath.row].marchioCopre
        cell.modello.text = searchResults.results[indexPath.row].modello
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





