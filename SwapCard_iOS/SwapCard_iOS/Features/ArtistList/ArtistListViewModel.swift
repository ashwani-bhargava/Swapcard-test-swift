//
//  ArtistListViewModel.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 06/03/21.
//

import Foundation

struct ArtistPresentable: Hashable {
    var name: String?
    var id: String?
    var disambiguation: String?
    var imageURL: String? //URL
    let unique = UUID()
}

struct ArtistListViewModel {
    var artistList: [ArtistPresentable]
}
