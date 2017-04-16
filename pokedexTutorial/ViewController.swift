//
//  ViewController.swift
//  pokedexTutorial
//
//  Created by Matthew Singleton on 4/14/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var pokemon = [Pokemon]()
  var filteredPokemon = [Pokemon]()
  var musicPlayer: AVAudioPlayer!
  var inSearchMode = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.searchBar.delegate = self
    
    searchBar.returnKeyType = UIReturnKeyType.done
    
    parsePokemonCSV()
    initAudio()
  }
  
  
  func initAudio() {
    
    let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
    
    do {
      
      musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
      musicPlayer.prepareToPlay()
      musicPlayer.numberOfLoops = -1
      musicPlayer.play()
      
    } catch let err as NSError {
      
      print(err.debugDescription)
      
    }
    
    
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
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "pokemonDetailVC" {
      
      if let detailsVC = segue.destination as? PokemonDetailViewController {
        
        if let poke = sender as? Pokemon  {
          
          detailsVC.pokemon = poke
          
        }
      }
    }
  }
  
  
  @IBAction func musicButtonPressed(_ sender: UIButton) {
    
    if musicPlayer.isPlaying {
      musicPlayer.pause()
      sender.alpha = 0.2
    } else {
      musicPlayer.play()
      sender.alpha = 1.0
    }
    
  }
  
  
  
} // End of Class


extension ViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchBar.text == nil || searchBar.text == "" {
      
      inSearchMode = false
      collectionView.reloadData()
      view.endEditing(true)
      
    } else {
      
      inSearchMode = true
      
      let lower = searchBar.text!.lowercased()
      
      filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
      collectionView.reloadData()
      
    }
  }
  
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    view.endEditing(true)
    
  }
  
}


extension ViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    var poke: Pokemon!
    
    if inSearchMode {
      
      poke = filteredPokemon[indexPath.row]
      
    } else {
      
      poke = pokemon[indexPath.row]
      
    }
    
    performSegue(withIdentifier: "pokemonDetailVC", sender: poke)
    
  }
  
}


extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    
    if inSearchMode {
      
      return filteredPokemon.count
      
    }
    return pokemon.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCellCollectionViewCell {
      
      let poke: Pokemon!
      
      if inSearchMode {
        
        poke = filteredPokemon[indexPath.row]
        cell.configureCell(poke)
        
      } else {
        
        poke = pokemon[indexPath.row]
        cell.configureCell(poke)
        
      }
      
      
      
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
