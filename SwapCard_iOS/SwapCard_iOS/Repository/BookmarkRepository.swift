//
//  BookmarkRepository.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 12/03/21.
//

import Foundation

protocol BookmarkRepository {
    func getBookmarkedArtists() -> [Artist]
    func isBookMarked(artist: Artist) -> Bool
    func bookmarkArtist(artist: Artist)
    func removeBookmarkArtist(artist: Artist)
}

class BookmarkRepoImplementation: BookmarkRepository {
    
    let repo: PersistanceStorageHelper<[Artist]>
    let key = "ArtistBookMarks"
    init(storage: PersistanceStorageHelper<[Artist]>) {
        self.repo = storage
    }
    
    func getBookmarkedArtists() -> [Artist] {
        return repo.getItem(key: key) ?? []
    }
    
    func isBookMarked(artist: Artist) -> Bool {
        let bookmarkedArtists = getBookmarkedArtists()
        return bookmarkedArtists.contains { (bookmarkedArtist) -> Bool in
            bookmarkedArtist.id == artist.id
        }
    }
    
    func bookmarkArtist(artist: Artist) {
        var bookMarkedArtist = getBookmarkedArtists()
        bookMarkedArtist.append(artist)
        saveBookMarkItems(artists: bookMarkedArtist)
    }
    
    func removeBookmarkArtist(artist: Artist){
        var bookMarkedArtists = getBookmarkedArtists()
        bookMarkedArtists.removeAll { (bookMarkedArtist) -> Bool in
            artist.id == bookMarkedArtist.id
        }
        saveBookMarkItems(artists: bookMarkedArtists)
    }
    
    private func saveBookMarkItems(artists: [Artist]) {
        try? repo.saveItem(item: artists, key: key)
    }
}
