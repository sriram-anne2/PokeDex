//
//  ViewController.swift
//  Pokedex
//
//  Created by Anne, Sriram on 5/8/20.
//  Copyright © 2020 CS50. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var pokemon: [Pokemon] = []
        
    override func viewDidLoad() {
        
        searchBar.delegate = self
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit-151")
        
        // this is to ensure that the url that we get is not null
        guard let u = url else {
            return
        }
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            // we don't want the data to be a null JSON
            guard let data = data else {
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                self.pokemon = pokemonList.results

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print("\(error)")
            }
            
        }.resume()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // implememnt search functionality here
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell",
                                                 for: indexPath)
        
        cell.textLabel?.text = capitalize(text: pokemon[indexPath.row].name)
        
        return cell
    }
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonSegue" {
            if let destination = segue.destination as? PokemonViewController {
                destination.pokemon = pokemon[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    
}

