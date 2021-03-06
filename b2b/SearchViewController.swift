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
        
        var cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
        cellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "LoadingCell")
        
        searchBar.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var searchResults = ResultArray()
    var isLoading = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
        // MARK:- Private Methods
    func iTunesURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:"http://10.11.14.78/copre/copre.php?functionName=tabulatoCopre2&ediel01=&ediel02=&ediel03=&ediel04=&marchio=&descrizione=%@&codiceArticolo=&barcode=&modello=", encodedText)
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

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            
            searchBar.resignFirstResponder()
            
            isLoading = true
            tableView.reloadData()
            
            searchResults.results = []
            
            let url = self.iTunesURL(searchText: searchBar.text!)
            
            let queue = DispatchQueue.global()
            queue.async {
                
                print ("URL: '\(url)'")
                
                if let data = self.performStoreRequest(with: url) {
                    self.searchResults = self.parse(data: data)!
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.tableView.reloadData()
                    }
                    return
                }
            }
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 1
        } else {
            return searchResults.results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
            
            cell.codiceArticoloGcc.text = searchResults.results[indexPath.row].codice
            cell.descrizioneArticolo.text = searchResults.results[indexPath.row].descrizione.capitalized
            cell.modello.text = searchResults.results[indexPath.row].modello
            cell.marchio.text = searchResults.results[indexPath.row].marchioCopre
            cell.giacenza.text = String(searchResults.results[indexPath.row].giacenza)
            cell.prezzo.text = String(searchResults.results[indexPath.row].nettoNetto)
            
            cell.codiceArticoloGcc.sizeToFit()
            cell.xView.layer.borderWidth = 2
            cell.xView.layer.backgroundColor = UIColor.white.cgColor
            cell.xView.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
            
            let darkGreen = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1)
            if searchResults.results[indexPath.row].giacenza > 0 {
                cell.giacenza.textColor = darkGreen
            }
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.results.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }
}





