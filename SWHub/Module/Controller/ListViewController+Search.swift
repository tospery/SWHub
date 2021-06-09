//
//  ListViewController+Search.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/4.
//

import UIKit

extension ListViewController {
    
    @objc func activeWhenSearchHistory(_ active: Any!) {
        guard let word = active as? String else { return }
        var history = SearchHistory.cachedObject() ?? SearchHistory.init()
        var words = [String].init()
        words.append(contentsOf: history.words)
        words.insert(word, at: 0)
        words.removeDuplicates()
        history.words = words
        SearchHistory.storeObject(history)
        self.navigator.push(
            Router.urlString(host: .search).url!
                .appendingPathComponent(Router.Path.result.rawValue)
                .appendingQueryParameters([
                    Parameter.keyword: word
                ])
        )
        MainScheduler.asyncInstance.schedule(()) { [weak self] _ -> Disposable in
            guard let `self` = self else { return Disposables.create {} }
            self.reactor?.action.onNext(.load)
            return Disposables.create {}
        }.disposed(by: self.disposeBag)
    }
    
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text, !word.isEmpty else { return }
        self.activeWhenSearchHistory(word)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
