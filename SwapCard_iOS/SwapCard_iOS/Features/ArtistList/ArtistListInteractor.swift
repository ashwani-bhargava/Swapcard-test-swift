//
//  ArtistListInteractor.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 07/03/21.
//

import Foundation

protocol ArtistListInteractorProtocol {
    func fetchArtistList(query: String?)
    func fetchMoreArtists()
    func bookMarkTapped(index: Int)
}

final class ArtistListInteractor: ArtistListInteractorProtocol {
    let artistService: ArtistServiceProtocol
    let presenter: ArtistListPresenterProtocol
    let bookmarkRepo: BookmarkRepository
    
    var cursor: String?
    var query: String?
    var hasMoreItems: Bool?
    var isLoadingQuery: Bool = false
    var searchTask: DispatchWorkItem?
    
    var list: [Artist]? {
        didSet{
            if let list = list {
                self.presenter.presentFetched(data: list)
            }
        }
    }
    
    private struct Constants{
        static let fetchCount = 20
    }
    
    init(artistService: ArtistServiceProtocol, presenter: ArtistListPresenterProtocol, bookmarkRepo: BookmarkRepository) {
        self.artistService = artistService
        self.presenter = presenter
        self.bookmarkRepo = bookmarkRepo
    }
    
    func fetchArtistList(query: String?) {
        self.query = query
        self.searchTask?.cancel()
        let task = DispatchWorkItem {[weak self] in
            guard let query = self?.query, !query.isEmpty  else {
                self?.presenter.presentError(message: "Need a search term")
                return
            }
            self?.getFreshArtistListFromNetwork(query: query)
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    func bookMarkTapped(index: Int) {
        guard let list = list, list.count > index else { return }
        // bookmark/unbookmark the new item accordingly
        let artist = list[index]
        if bookmarkRepo.isBookMarked(artist: artist){
            bookmarkRepo.removeBookmarkArtist(artist: artist)
        } else {
            bookmarkRepo.bookmarkArtist(artist: artist)
        }
    }
    
    private func getFreshArtistListFromNetwork(query: String){
        artistService.getArtistList(search: query, endCursor: nil, count: Constants.fetchCount) {[weak self] (result) in
            switch result {
            case .success(let response):
                if let response = response {
                    self?.parseResponse(response: response,
                                        shouldAppend: false)
                }
            case .failure(let error):
                print("display error \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMoreArtists() {
        guard let query = query, let hasMoreItmes = hasMoreItems, hasMoreItmes, !isLoadingQuery else { return }
        isLoadingQuery = true
        artistService.getArtistList(search: query, endCursor: cursor, count: Constants.fetchCount) { [weak self] (result) in
            self?.isLoadingQuery = false
            switch result {
            case .success(let response):
                if let response = response {
                    self?.parseResponse(response: response, shouldAppend: true)
                }
            case .failure(let error):
                print("display error \(error.localizedDescription)")
            }
        }
    }
    
    func parseResponse(response: ArtistListResponse, shouldAppend: Bool) {
        if let items = response.list {
            if shouldAppend {
                self.list?.append(contentsOf: items)
            } else {
                self.list = response.list
            }
        }
        self.cursor = response.cursor
        self.hasMoreItems = response.hasMoreItems
    }
}
