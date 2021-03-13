//
//  BookmarkListInteractor.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 13/03/21.
//

import Foundation

protocol BookmarkListInteractorProtocol {
    func fetchArtistList()
    func bookmarkTappedAt(index: Int)
}

final class BookmarkListInteractor: BookmarkListInteractorProtocol {
    let bookmarkRepo: BookmarkRepository
    let presenter: ArtistListPresenterProtocol
    var artists: [Artist] = []
    init(bookmarkRepo: BookmarkRepository, presenter: ArtistListPresenterProtocol) {
        self.bookmarkRepo = bookmarkRepo
        self.presenter = presenter
    }
    
    func fetchArtistList() {
        artists = bookmarkRepo.getBookmarkedArtists()
        presenter.presentFetched(data: artists)
    }
    
    func bookmarkTappedAt(index: Int) {
        guard artists.count > index else { return }
        // bookmark/unbookmark the new item accordingly
        let artist = artists[index]
        if bookmarkRepo.isBookMarked(artist: artist){
            bookmarkRepo.removeBookmarkArtist(artist: artist)
        } else {
            bookmarkRepo.bookmarkArtist(artist: artist)
        }
        fetchArtistList()
    }
}
