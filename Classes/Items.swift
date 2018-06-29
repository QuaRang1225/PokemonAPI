//
//  Items.swift
//  PokemonKit
//
//  Created by Christopher Jennewein on 6/27/18.
//

import Foundation


/// An item is an object in the games which the player can pick up, keep in their bag, and use in some manner. They have various uses, including healing, powering up, helping catch Pokémon, or to access a new area.
open class PKMItem: Codable, SelfDecodable {
    
    /// The identifier for this item resource
    open var id: Int?
    
    /// The name for this item resource
    open var name: String?
    
    /// The price of this item in stores
    open var cost: Int?
    
    /// The power of the move Fling when used with this item.
    open var flingPower: Int?
    
    /// The effect of the move Fling when used with this item
    open var flingEffect: PKMNamedAPIResource?
    
    /// A list of attributes this item has
    open var attributes: [PKMNamedAPIResource]?
    
    /// The category of items this item falls into
    open var category: PKMItemCategory?
    
    /// The effect of this ability listed in different languages
    open var effectEntries: [PKMVerboseEffect]?
    
    /// The flavor text of this ability listed in different languages
    open var flavorTextEntries: [PKMVersionGroupFlavorText]?
    
    /// A list of game indices relevent to this item by generation
    open var gameIndices: [PKMGenerationGameIndex]?
    
    /// The name of this item listed in different languages
    open var names: [PKMName]?
    
    /// A set of sprites used to depict this item in the game
    open var sprites: PKMItemSprites?
    
    /// A list of Pokémon that might be found in the wild holding this item
    open var heldByPokemon: [PKMItemHolderPokemon]?
    
    /// An evolution chain this item requires to produce a bay during mating
    open var babyTriggerFor: PKMAPIResource?
    
    /// A list of the machines related to this item
    open var machines: [PKMMachineVersionDetail]?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


/// Item Sprites
open class PKMItemSprites: Codable {
    /// The default depiction of this item
    open var `default`: String?
}


/// Item Holder Pokemon
open class PKMItemHolderPokemon: Codable, SelfDecodable {
    
    /// The Pokémon that holds this item
    open var pokemon: String?
    
    /// The details for the version that this item is held in by the Pokémon
    open var versionDetails: [PKMItemHolderPokemonVersionDetail]?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


/// Item Holder Pokemon Version Detail
open class PKMItemHolderPokemonVersionDetail: Codable {
    
    /// How often this Pokémon holds this item in this version
    open var rarity: String?
    
    /// The version that this item is held in by the Pokémon
    open var version: PKMNamedAPIResource?
}


/// Item attributes define particular aspects of items, e.g. "usable in battle" or "consumable".
open class PKMItemAttribute: Codable {
    
    /// The identifier for this item attribute resource
    open var id: Int?
    
    /// The name for this item attribute resource
    open var name: String?
    
    /// A list of items that have this attribute
    open var items: [PKMNamedAPIResource]?
    
    /// The name of this item attribute listed in different languages
    open var names: [PKMName]?
    
    /// The description of this item attribute listed in different languages
    open var descriptions: [PKMDescription]?
}


/// Item categories determine where items will be placed in the players bag.
open class PKMItemCategory: Codable {
    
    /// The identifier for this item category resource
    open var id: Int?
    
    /// The name for this item category resource
    open var name: String?
    
    /// A list of items that are a part of this category
    open var items: [PKMNamedAPIResource]?
    
    /// The name of this item category listed in different languages
    open var names: [PKMName]?
    
    /// The pocket items in this category would be put in
    open var pocket: PKMNamedAPIResource?
}


/// The various effects of the move "Fling" when used with different items.
open class PKMItemFlingEffect: Codable, SelfDecodable {
    
    /// The identifier for this fling effect resource
    open var id: Int?
    
    /// The name for this fling effect resource
    open var name: String?
    
    /// The result of this fling effect listed in different languages
    open var effectEntries: [PKMEffect]?
    
    /// A list of items that have this fling effect    list
    open var items: [PKMNamedAPIResource]?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


/// Pockets within the players bag used for storing items by category.
open class PKMItemPocket: Codable {
    
    /// The identifier for this item pocket resource
    open var id: Int?
    
    /// The name for this item pocket resource
    open var name: String?
    
    /// A list of item categories that are relevent to this item pocket
    open var categories: [PKMNamedAPIResource]?
    
    /// The name of this item pocket listed in different languages
    open var names: [PKMName]?
}



// MARK: - Web Services

open class ItemService {
    /**
     Fetch Items list
     */
    public func fetchItems(completion: @escaping (_ result: Result<PKMPagedObject>) -> Void) {
        let urlStr = baseURL + "/item"
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Information
     
     - parameter itemId: Item ID
     */
    public func fetchItem(_ itemId: String, completion: @escaping (_ result: Result<PKMItem>) -> Void) {
        let urlStr = baseURL + "/item/" + itemId
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Attributes list
     */
    public func fetchItemAttributes(completion: @escaping (_ result: Result<PKMPagedObject>) -> Void) {
        let urlStr = baseURL + "/item-attribute"
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Attribute Information
     
     - parameter itemAttributeId: Item Attribute ID
     */
    public func fetchItemAttribute(_ itemAttributeId: String, completion: @escaping (_ result: Result<PKMItemAttribute>) -> Void) {
        let urlStr = baseURL + "/item-attribute/" + itemAttributeId
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Categories list
     */
    public func fetchItemCategories(completion: @escaping (_ result: Result<PKMPagedObject>) -> Void) {
        let urlStr = baseURL + "/item-category"
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Category Information
     
     - parameter itemCategoryId: Item Category ID
     */
    public func fetchItemCategory(_ itemCategoryId: String, completion: @escaping (_ result: Result<PKMItemCategory>) -> Void) {
        let urlStr = baseURL + "/item-category/" + itemCategoryId
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Fling Effects list
     */
    public func fetchItemFlingEffects(completion: @escaping (_ result: Result<PKMPagedObject>) -> Void) {
        let urlStr = baseURL + "/item-fling-effect"
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Fling Effect Information
     
     - parameter itemFlingEffectsId: Item Fling Effect ID
     */
    public func fetchItemFlingEffect(_ itemFlingEffectsId: String, completion: @escaping (_ result: Result<PKMItemFlingEffect>) -> Void) {
        let urlStr = baseURL + "/item-fling-effect/" + itemFlingEffectsId
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Pockets list
     */
    public func fetchItemPockets(completion: @escaping (_ result: Result<PKMPagedObject>) -> Void) {
        let urlStr = baseURL + "/item-pocket"
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
    
    
    /**
     Fetch Item Pocket Information
     
     - parameter itemPocketId: Item Pocket ID
     */
    public func fetchItemPocket(_ itemPocketId: String, completion: @escaping (_ result: Result<PKMItemPocket>) -> Void) {
        let urlStr = baseURL + "/item-pocket/" + itemPocketId
        
        HTTPWebService.callWebService(url: URL(string: urlStr), method: .get) { result in
            result.decode(completion: completion)
        }
    }
}
