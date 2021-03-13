//
//  ArtistListViewController.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 06/03/21.
//

import UIKit

class ArtistListViewControllerActions {
    var onViewLoad: (() -> Void)?
    var onViewAppear: (() -> Void)?
    var onPullToRefresh: (() -> Void)?
    var onReachingEndOfItems: (() -> Void)?
    var onBookMarkTapped: ((_ index: Int) -> Void)?
}

protocol ArtistListDisplayProtocol: class {
    func display(viewModel: ArtistListViewModel)
    func displayError(_ errorString: String)
}

final class ArtistListViewController: UIViewController, ArtistListDisplayProtocol {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, ListDisplayable>?
    
    var actions: ArtistListViewControllerActions?
    private lazy var layout: UICollectionViewCompositionalLayout = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }()
    
    private var viewModel: ArtistListViewModel? {
        didSet {
            //refresh the view automatically as soon as the viewModel is set
            refresh()
        }
    }
    
    //MARK:- Private Data Structures
    private enum Section {
        case main
    }
    
    private enum ListDisplayable: Hashable {
        case artist(ArtistPresentable)
    }
    
    //MARK:- View Lifecycle and Config
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        actions?.onViewAppear?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actions?.onViewLoad?()
        configureUI()
    }
    
    func display(viewModel: ArtistListViewModel) {
        self.viewModel = viewModel
    }
    
    func displayError(_ errorString: String) {
        let alert = UIAlertController(title: nil, message: errorString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func refresh() {
        if let list = viewModel?.artistList.compactMap({ ListDisplayable.artist($0)}) {
            applyInitialSnapShot(list: list)
        }
    }
    
    private  func applyInitialSnapShot(list: [ListDisplayable]) {
        let snapshot = initialSnapShot(list: list)
        self.dataSource?.apply(snapshot, to: .main, animatingDifferences: true)
    }
    
    private func initialSnapShot(list: [ListDisplayable]) -> NSDiffableDataSourceSectionSnapshot<ListDisplayable> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<ListDisplayable>()
        snapshot.append(list)
        return snapshot
    }
    
    //MARK:- View configuration
    private func configureUI() {
        configureCollectionView()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        dataSource = UICollectionViewDiffableDataSource<Section, ListDisplayable>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case let .artist(artist):
                return collectionView.dequeueConfiguredReusableCell(using: self.configuredArtistCell(), for: indexPath, item: artist)
            }
        }
    }
    
    private func configuredArtistCell() -> UICollectionView.CellRegistration<ArtistListCollectionViewCell, ArtistPresentable> {
        return UICollectionView.CellRegistration<ArtistListCollectionViewCell, ArtistPresentable>.init(cellNib: ArtistListCollectionViewCell.nib) { (cell, indexPath, artist) in
            cell.setup(artist: artist) {[weak self] (artistPresentable) in
                self?.actions?.onBookMarkTapped?(indexPath.row)
            }
        }
    }
}

extension ArtistListViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) - 100) {
            //reached bottom
            actions?.onReachingEndOfItems?()
        }
    }
}
