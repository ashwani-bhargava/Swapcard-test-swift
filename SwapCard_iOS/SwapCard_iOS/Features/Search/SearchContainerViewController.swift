//
//  SearchContainerViewController.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 13/03/21.
//

import UIKit
class SearchContainerViewControllerActions {
    var onSearchWithTerm: ((String) -> Void)?
}

class SearchContainerViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultContainerView: UIView!
    var actions: SearchContainerViewControllerActions?
    let resultViewController: UIViewController
    init(resultViewController: UIViewController) {
        self.resultViewController = resultViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        displayChildViewController()
    }
    
    func displayChildViewController() {
        addChild(resultViewController)
        resultViewController.view.frame = resultContainerView.bounds
        resultContainerView.addSubview(resultViewController.view)
        resultViewController.didMove(toParent: self)
        resultViewController.view.makeEdgesEqualToSuperView()
    }
    
    private func configureSearchBar() {
        self.searchBar.delegate = self
    }
}

extension SearchContainerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        actions?.onSearchWithTerm?(searchText)
    }
}
