//
//  Network.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 05/03/21.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://graphbrainz.herokuapp.com/")!)
}
