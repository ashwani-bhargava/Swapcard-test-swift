//
//  NetworkClient.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 07/03/21.
//

import Foundation
import Apollo
class NetworkClient {
    let apollo: ApolloClientProtocol
    
    init(baseUrl: URL) {
        apollo = ApolloClient(url: baseUrl)
    }
}
