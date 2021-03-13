//
//  ArtistService.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 07/03/21.
//

import Foundation
import Apollo

struct ArtistListResponse {
    let cursor: String?
    let list: [Artist]?
    let hasMoreItems: Bool?
}

protocol ArtistServiceProtocol {
    @discardableResult func getArtistList(search: String, endCursor: String?, count: Int?, completion: @escaping ((Result<ArtistListResponse?, Error>) -> ())) -> Cancellable
}

class ArtistService: ArtistServiceProtocol {
    let networkClient: ApolloClientProtocol
    init(networkClient: ApolloClientProtocol) {
        self.networkClient = networkClient
    }
    
    @discardableResult func getArtistList(search: String, endCursor: String?, count: Int?, completion: @escaping ((Result<ArtistListResponse?, Error>) -> ())) -> Cancellable {
        return networkClient.fetch(query: ArtistsQuery(query: search, cursor: endCursor, first: count), cachePolicy: CachePolicy.returnCacheDataElseFetch, contextIdentifier: nil, queue: DispatchQueue.main) { [weak self](result) in
            switch result {
            case .success(let graphQLResult):
                let response = self?.convertGrapthQLResultToResponse(result: graphQLResult)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func convertGrapthQLResultToResponse(result: GraphQLResult<ArtistsQuery.Data>) -> ArtistListResponse {
        let cursor = result.data?.search?.artists?.pageInfo.endCursor
        let hasMoreItems = result.data?.search?.artists?.pageInfo.hasNextPage
        let artistsNodes = result.data?.search?.artists?.nodes
        
        let list = artistsNodes?.compactMap({ (node) -> Artist? in
            guard let artistFragment = node?.fragments.artistBasicFragment else {
                return nil
            }
            let fanArtUrl = artistFragment.fanArt?.thumbnails?.first??.url
            return Artist(name: artistFragment.name,
                          id: artistFragment.id,
                          disambiguation: artistFragment.disambiguation,
                          iconURL: fanArtUrl)
        })
        return ArtistListResponse(cursor: cursor,
                                  list: list,
                                  hasMoreItems: hasMoreItems)
    }
}


