//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Anne, Sriram on 5/8/20.
//  Copyright © 2020 CS50. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        type1Label.text = ""
        type2Label.text = ""
        
        let url = URL(string: pokemon.url)
        
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.nameLabel.text = self.pokemon.name
                    self.numLabel.text = String(format: "#%03d", pokemonData.id)
                    
                    for eachType in pokemonData.types {
                        if eachType.slot == 1 {
                            self.type1Label.text = eachType.type.name
                        }
                        if eachType.slot == 2 {
                            self.type2Label.text = eachType.type.name
                        }
                    }
               }
            }
            catch let error {
                print("\(error)")
            }
            
        }.resume()
    }

}
