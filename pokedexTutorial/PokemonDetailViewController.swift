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
  @IBOutlet weak var mainImg: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var defenseLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var pokedexLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  @IBOutlet weak var attackLabel: UILabel!
  @IBOutlet weak var evoLabel: UILabel!
  @IBOutlet weak var currentEvoImg: UIImageView!
  @IBOutlet weak var nextEvoImg: UIImageView!
  
  

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
    }


  @IBAction func backButtonTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
