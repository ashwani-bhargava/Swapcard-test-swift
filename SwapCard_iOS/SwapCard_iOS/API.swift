// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ArtistsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Artists($query: String!, $cursor: String, $first: Int) {
      search {
        __typename
        artists(query: $query, first: $first, after: $cursor) {
          __typename
          pageInfo {
            __typename
            endCursor
            hasNextPage
          }
          nodes {
            __typename
            ...ArtistBasicFragment
          }
        }
      }
    }
    """

  public let operationName: String = "Artists"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + ArtistBasicFragment.fragmentDefinition)
    return document
  }

  public var query: String
  public var cursor: String?
  public var first: Int?

  public init(query: String, cursor: String? = nil, first: Int? = nil) {
    self.query = query
    self.cursor = cursor
    self.first = first
  }

  public var variables: GraphQLMap? {
    return ["query": query, "cursor": cursor, "first": first]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("search", type: .object(Search.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.flatMap { (value: Search) -> ResultMap in value.resultMap }])
    }

    /// Search for MusicBrainz entities using Lucene query syntax.
    public var search: Search? {
      get {
        return (resultMap["search"] as? ResultMap).flatMap { Search(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SearchQuery"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("artists", arguments: ["query": GraphQLVariable("query"), "first": GraphQLVariable("first"), "after": GraphQLVariable("cursor")], type: .object(Artist.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(artists: Artist? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchQuery", "artists": artists.flatMap { (value: Artist) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Search for artist entities matching the given query.
      public var artists: Artist? {
        get {
          return (resultMap["artists"] as? ResultMap).flatMap { Artist(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "artists")
        }
      }

      public struct Artist: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ArtistConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ArtistConnection", "pageInfo": pageInfo.resultMap, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        /// A list of nodes in the connection (without going through the
        /// `edges` field).
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Artist"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ArtistBasicFragment.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var artistBasicFragment: ArtistBasicFragment {
              get {
                return ArtistBasicFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class ArtistQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Artist {
      node(id: "QXJ0aXN0OjE0NGVmNTI1LTg1ZTktNDBjMy04MzM1LTAyYzMyZDA4NjFmMw==") {
        __typename
        ...ArtistDetailsFragment
      }
    }
    """

  public let operationName: String = "Artist"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + ArtistDetailsFragment.fragmentDefinition)
    document.append("\n" + ArtistBasicFragment.fragmentDefinition)
    return document
  }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("node", arguments: ["id": "QXJ0aXN0OjE0NGVmNTI1LTg1ZTktNDBjMy04MzM1LTAyYzMyZDA4NjFmMw=="], type: .object(Node.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(node: Node? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
    }

    /// Fetches an object given its ID
    public var node: Node? {
      get {
        return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "node")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Area", "Artist", "Recording", "Release", "Disc", "Label", "Collection", "Event", "Instrument", "Place", "ReleaseGroup", "Series", "Work", "URL"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(ArtistDetailsFragment.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makeArea() -> Node {
        return Node(unsafeResultMap: ["__typename": "Area"])
      }

      public static func makeRecording() -> Node {
        return Node(unsafeResultMap: ["__typename": "Recording"])
      }

      public static func makeRelease() -> Node {
        return Node(unsafeResultMap: ["__typename": "Release"])
      }

      public static func makeDisc() -> Node {
        return Node(unsafeResultMap: ["__typename": "Disc"])
      }

      public static func makeLabel() -> Node {
        return Node(unsafeResultMap: ["__typename": "Label"])
      }

      public static func makeCollection() -> Node {
        return Node(unsafeResultMap: ["__typename": "Collection"])
      }

      public static func makeEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "Event"])
      }

      public static func makeInstrument() -> Node {
        return Node(unsafeResultMap: ["__typename": "Instrument"])
      }

      public static func makePlace() -> Node {
        return Node(unsafeResultMap: ["__typename": "Place"])
      }

      public static func makeReleaseGroup() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReleaseGroup"])
      }

      public static func makeSeries() -> Node {
        return Node(unsafeResultMap: ["__typename": "Series"])
      }

      public static func makeWork() -> Node {
        return Node(unsafeResultMap: ["__typename": "Work"])
      }

      public static func makeURL() -> Node {
        return Node(unsafeResultMap: ["__typename": "URL"])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var artistDetailsFragment: ArtistDetailsFragment? {
          get {
            if !ArtistDetailsFragment.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
            return ArtistDetailsFragment(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct ArtistDetailsFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ArtistDetailsFragment on Artist {
      __typename
      id
      name
      disambiguation
      relationships {
        __typename
        artists {
          __typename
          nodes {
            __typename
            target {
              __typename
              ...ArtistBasicFragment
            }
          }
        }
      }
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
      GraphQLField("relationships", type: .object(Relationship.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil, relationships: Relationship? = nil) {
    self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation, "relationships": relationships.flatMap { (value: Relationship) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The official name of the entity.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A comment used to help distinguish identically named entitites.
  public var disambiguation: String? {
    get {
      return resultMap["disambiguation"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "disambiguation")
    }
  }

  /// Relationships between this entity and other entitites.
  public var relationships: Relationship? {
    get {
      return (resultMap["relationships"] as? ResultMap).flatMap { Relationship(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "relationships")
    }
  }

  public struct Relationship: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Relationships"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("artists", type: .object(Artist.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(artists: Artist? = nil) {
      self.init(unsafeResultMap: ["__typename": "Relationships", "artists": artists.flatMap { (value: Artist) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A list of relationships between these two entity types.
    public var artists: Artist? {
      get {
        return (resultMap["artists"] as? ResultMap).flatMap { Artist(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "artists")
      }
    }

    public struct Artist: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["RelationshipConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "RelationshipConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes in the connection (without going through the
      /// `edges` field).
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Relationship"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("target", type: .nonNull(.object(Target.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(target: Target) {
          self.init(unsafeResultMap: ["__typename": "Relationship", "target": target.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The target entity.
        public var target: Target {
          get {
            return Target(unsafeResultMap: resultMap["target"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "target")
          }
        }

        public struct Target: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Area", "Artist", "Recording", "Release", "Track", "Label", "Collection", "Event", "Instrument", "Place", "ReleaseGroup", "Series", "Work", "URL"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ArtistBasicFragment.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public static func makeArea() -> Target {
            return Target(unsafeResultMap: ["__typename": "Area"])
          }

          public static func makeRecording() -> Target {
            return Target(unsafeResultMap: ["__typename": "Recording"])
          }

          public static func makeRelease() -> Target {
            return Target(unsafeResultMap: ["__typename": "Release"])
          }

          public static func makeTrack() -> Target {
            return Target(unsafeResultMap: ["__typename": "Track"])
          }

          public static func makeLabel() -> Target {
            return Target(unsafeResultMap: ["__typename": "Label"])
          }

          public static func makeCollection() -> Target {
            return Target(unsafeResultMap: ["__typename": "Collection"])
          }

          public static func makeEvent() -> Target {
            return Target(unsafeResultMap: ["__typename": "Event"])
          }

          public static func makeInstrument() -> Target {
            return Target(unsafeResultMap: ["__typename": "Instrument"])
          }

          public static func makePlace() -> Target {
            return Target(unsafeResultMap: ["__typename": "Place"])
          }

          public static func makeReleaseGroup() -> Target {
            return Target(unsafeResultMap: ["__typename": "ReleaseGroup"])
          }

          public static func makeSeries() -> Target {
            return Target(unsafeResultMap: ["__typename": "Series"])
          }

          public static func makeWork() -> Target {
            return Target(unsafeResultMap: ["__typename": "Work"])
          }

          public static func makeURL() -> Target {
            return Target(unsafeResultMap: ["__typename": "URL"])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var artistBasicFragment: ArtistBasicFragment? {
              get {
                if !ArtistBasicFragment.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
                return ArtistBasicFragment(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public struct ArtistBasicFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ArtistBasicFragment on Artist {
      __typename
      id
      name
      disambiguation
      fanArt {
        __typename
        thumbnails {
          __typename
          url
        }
      }
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
      GraphQLField("fanArt", type: .object(FanArt.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil, fanArt: FanArt? = nil) {
    self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation, "fanArt": fanArt.flatMap { (value: FanArt) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The official name of the entity.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A comment used to help distinguish identically named entitites.
  public var disambiguation: String? {
    get {
      return resultMap["disambiguation"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "disambiguation")
    }
  }

  /// Images of the artist from [fanart.tv](https://fanart.tv/).
  /// This field is provided by the fanart.tv extension.
  public var fanArt: FanArt? {
    get {
      return (resultMap["fanArt"] as? ResultMap).flatMap { FanArt(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "fanArt")
    }
  }

  public struct FanArt: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["FanArtArtist"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("thumbnails", type: .list(.object(Thumbnail.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(thumbnails: [Thumbnail?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "FanArtArtist", "thumbnails": thumbnails.flatMap { (value: [Thumbnail?]) -> [ResultMap?] in value.map { (value: Thumbnail?) -> ResultMap? in value.flatMap { (value: Thumbnail) -> ResultMap in value.resultMap } } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A list of 1000x1000 JPG thumbnail images picturing the artist (usually
    /// containing every member of a band).
    public var thumbnails: [Thumbnail?]? {
      get {
        return (resultMap["thumbnails"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Thumbnail?] in value.map { (value: ResultMap?) -> Thumbnail? in value.flatMap { (value: ResultMap) -> Thumbnail in Thumbnail(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Thumbnail?]) -> [ResultMap?] in value.map { (value: Thumbnail?) -> ResultMap? in value.flatMap { (value: Thumbnail) -> ResultMap in value.resultMap } } }, forKey: "thumbnails")
      }
    }

    public struct Thumbnail: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["FanArtImage"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(url: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "FanArtImage", "url": url])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The URL of the image.
      public var url: String? {
        get {
          return resultMap["url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }
    }
  }
}
