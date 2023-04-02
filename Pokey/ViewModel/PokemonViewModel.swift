//
//  PokemonViewModel.swift
//  Pokey
//
//  Created by AlecNipp on 11/16/22.
//

import Foundation

/// The ViewModel for a PokemonDetailView. It has one Published property, which is the model of the Pokemon currently in the view.
class PokemonDetailViewModel: ObservableObject {
    /// Tracks the Pokemon in the view currently. Note that this property can be changed.
    @Published var model: Pokemon
    
    /// The initializer for this ViewModel accepts a `Pokemon` as the model.
    init(pokemon: Pokemon) {
        self.model = pokemon
    }
    
    var name: String {
        return model.name
    }
    // MARK: Change this disgusting metric.
    var height: String {
        let str = model.height
        
        let strDropped = str.dropLast(2)
        let number = Double(strDropped)
        let converted = (number ?? 0) * 3.28084
        let rounded = round((converted * 100)) / 100.0
        
        return "\(rounded) feet"
    }
    // MARK: Change this disgusting metric.
    var weight: String {
        let str = model.weight
        
        let strDropped = str.dropLast(3)
        let number = Double(strDropped)
        let converted = (number ?? 0) * 2.2
        let rounded = round((converted * 100)) / 100.0
        
        
        return "\(rounded) lbs"
    }
    
    var id: Int {
        return model.id
    }
    
    var egg: String {
        return model.egg.rawValue
    }
    
    var number: String {
        return "#" + model.num
    }
        
    var imageURL: URL? {
        return model.imageURL
    }
    
    var weaknesses: [TypeElement] {
        return model.weaknesses
    }
    // MARK: Computed property getting a list of the Pokemon's next evolutions.
    var nextEvolutions: [Pokemon]? {
        var nextEvolutions: [Pokemon] = []
        
        for pokemon in model.nextEvolution ?? [] {
            nextEvolutions.append(PokedexService.shared.getPokemonFromNum(num: pokemon.num))
        }
        
        return nextEvolutions
        
    }
    // MARK: Computed property getting a list of the Pokemon's previous evolutions.
    var prevEvolutions: [Pokemon]? {
        var prevEvolutions: [Pokemon] = []
        
        for pokemon in model.prevEvolution ?? [] {
            prevEvolutions.append(PokedexService.shared.getPokemonFromNum(num: pokemon.num))
        }
        
        return prevEvolutions
        
    }
    // MARK: Returns the list of Pokemon in this Pokemon's evolution series. This will be a list of previous evolutions + current form + next evolutions
    var evolutionSeries: [Pokemon] {
        var evolutionSeries: [Pokemon] = []
        
        for pokemon in prevEvolutions ?? [] {
            evolutionSeries.append(pokemon)
        }
        
        evolutionSeries.append(model)
        
        for pokemon in nextEvolutions ?? [] {
            evolutionSeries.append(pokemon)
        }
        
        return evolutionSeries
    }
}
