//
//  ArtistListPresenter.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 06/03/21.
//

import Foundation

protocol ArtistListPresenterProtocol {
    func presentFetched(data: [Artist])
    func presentError(message: String)
}

final class ArtistListPresenter: ArtistListPresenterProtocol {
    weak var view: ArtistListDisplayProtocol?
    init(view: ArtistListDisplayProtocol) {
        self.view = view
    }
    
    func presentFetched(data: [Artist]) {
        let list = data.compactMap { (artist) -> ArtistPresentable? in
            return ArtistPresentable(name: artist.name,
                                     id: artist.id,
                                     disambiguation: artist.disambiguation,
                                     imageURL: artist.iconURL)
        }
        view?.display(viewModel: ArtistListViewModel(artistList: list))
    }
    
    func presentError(message: String) {
        view?.displayError(message)
    }
}

