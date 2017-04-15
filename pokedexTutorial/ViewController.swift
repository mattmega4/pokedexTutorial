//
//  ViewController.swift
//  pokedexTutorial
//
//  Created by Matthew Singleton on 4/14/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var pokemon = [Pokemon]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    
    parsePokemonCSV()
  }
  
  
  func parsePokemonCSV() {
    
    let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
    
    do {
      
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
      print(rows)
      
      for row in rows {
        let pokeId = Int(row["id"]!)!
        let name = row["identifier"]!
        
        let poke = Pokemon(name: name, pokedexId: pokeId)
        pokemon.append(poke)
        
      }
      
    } catch let err as NSError {
      
      print(err.debugDescription)
      
    }
    
  }
  
  
  
  
  
  
  
} // End of Class


extension ViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
  }
  
}


extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemon.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCellCollectionViewCell {
      
      let poke = pokemon[indexPath.row]
      
      cell.configureCell(poke)
      
      return cell
      
    } else {
      return UICollectionViewCell()
    }
  }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 105, height: 105)
  }
}
