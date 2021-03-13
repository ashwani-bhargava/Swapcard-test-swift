//
//  SceneDelegate.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 05/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let scene = (scene as? UIWindowScene), let url = URL(string: "https://graphbrainz.herokuapp.com/") else { return }
        
        let network = NetworkClient(baseUrl: url)
        let storage = PersistanceStorageHelper<[Artist]>()
        let bookmarkRepo = BookmarkRepoImplementation(storage: storage)
        let tabBarController = UITabBarController()
        let artistListVC = composeArtistListView(network: network, bookmarkRepo: bookmarkRepo)
        let bookmarkVC = composeBookmarkListView(bookmarkRepo: bookmarkRepo)
        tabBarController.setViewControllers([artistListVC, bookmarkVC], animated: false)
        
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    func composeArtistListView(network: NetworkClient, bookmarkRepo: BookmarkRepository) -> UIViewController {
        let service = ArtistService.init(networkClient: network.apollo)
        let viewController = ArtistListViewController()
        let presenter = ArtistListPresenter(view: viewController)
        let actions  = ArtistListViewControllerActions()
        
        let searchAction = SearchContainerViewControllerActions()
        
        let searchController = SearchContainerViewController(resultViewController: viewController)
        let interactor = ArtistListInteractor(artistService: service,
                                              presenter: presenter,
                                              bookmarkRepo: bookmarkRepo)
        searchAction.onSearchWithTerm = interactor.fetchArtistList(query:)
        actions.onReachingEndOfItems = interactor.fetchMoreArtists
        actions.onBookMarkTapped = interactor.bookMarkTapped(index:)
        
        let tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        searchController.tabBarItem = tabBarItem
        
        
        viewController.actions = actions
        searchController.actions = searchAction
        return searchController
    }
    
    func composeBookmarkListView(bookmarkRepo: BookmarkRepository) -> UIViewController {
        let viewController = ArtistListViewController()
        let presenter = ArtistListPresenter(view: viewController)
        let interactor = BookmarkListInteractor(bookmarkRepo: bookmarkRepo, presenter: presenter)
        let actions  = ArtistListViewControllerActions()
        actions.onViewAppear = interactor.fetchArtistList
        actions.onBookMarkTapped = interactor.bookmarkTappedAt(index:)
        let tabBarItem = UITabBarItem(title: "Bookmarks", image: nil, selectedImage: nil)
        viewController.tabBarItem = tabBarItem
        viewController.actions = actions
        return viewController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

