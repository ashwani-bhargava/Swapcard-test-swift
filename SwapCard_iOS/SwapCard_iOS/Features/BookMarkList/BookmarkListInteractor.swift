//
//  BookmarkListInteractor.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 13/03/21.
//

import Foundation

protocol BookmarkListInteractorProtocol {
    func fetchArtistList()
}

final class BookmarkListInteractor: BookmarkListInteractorProtocol {
    let bookmarkRepo: BookmarkRepository
    let presenter: ArtistListPresenterProtocol
    init(bookmarkRepo: BookmarkRepository, presenter: ArtistListPresenterProtocol) {
        self.bookmarkRepo = bookmarkRepo
        self.presenter = presenter
    }
    
    func fetchArtistList() {
        let artists = bookmarkRepo.getBookmarkedArtists()
        presenter.presentFetched(data: artists)
    }
}
