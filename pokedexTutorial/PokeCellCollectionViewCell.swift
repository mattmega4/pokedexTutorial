//
//  PokeCellCollectionViewCell.swift
//  pokedexTutorial
//
//  Created by Matthew Singleton on 4/14/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var thumbImg: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  var pokemon: Pokemon!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 5.0
    
  }
  
  func configureCell(_ pokemon: Pokemon) {
    
    self.pokemon = pokemon
    
    nameLabel.text = self.pokemon.name.capitalized
    thumbImg.image = UIImage.init(named: "\(self.pokemon.pokedexId)")
    
  }
  
  
  
}
