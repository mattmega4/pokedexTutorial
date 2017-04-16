//
//  PokemonDetailViewController.swift
//  pokedexTutorial
//
//  Created by Matthew Singleton on 4/15/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
  
  var pokemon: Pokemon!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  
  
  

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
    }


}
