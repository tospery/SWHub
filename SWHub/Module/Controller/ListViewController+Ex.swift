//
//  ListViewController+Ex.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/21.
//

import UIKit

// swiftlint:disable function_body_length
extension ListViewController {
    
    func toAction(reactor: ListViewReactor) {
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        self.rx.refresh.map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.rx.loadMore.map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
//        reactor.action.filter { $0 == .login }
//            .subscribeNext(weak: self, type(of: self).login)
//            .disposed(by: self.disposeBag)
    }
    
    func fromState(reactor: ListViewReactor) {
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isRefreshing }
            .distinctUntilChanged()
            .bind(to: self.rx.refreshing)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoadingMore }
            .distinctUntilChanged()
            .bind(to: self.rx.loadingMore)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isActivating }
            .distinctUntilChanged()
            .bind(to: self.rx.activating)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.noMoreData }
            .distinctUntilChanged()
            .bind(to: self.rx.noMoreData)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.data.issue }
            .distinctUntilChanged()
            .skip(1)
            .subscribeNext(weak: self, type(of: self).handleIssue)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.user }
            .distinctUntilChanged()
            .skip(1)
            .do(onNext: { user in
                log("用户监控(\(reactor.host), \(String(describing: reactor.path))): \(String(describing: user))")
            })
            .subscribeNext(weak: self, type(of: self).handleUser)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.active }
            .distinctUntilChanged { SWFrame.compareAny($0, $1) }
            .skip(1)
            .subscribeNext(weak: self, type(of: self).active)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.error }
            .distinctUntilChanged({ $0?.asSWFError == $1?.asSWFError })
            .bind(to: self.rx.error)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.sections }
            .distinctUntilChanged()
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
    func active(active: Any?) {
        guard let host = self.reactor?.host else { return }
        let selector = Selector.init(
            "active/when/\(host.rawValue)/\(self.reactor?.path?.rawValue ?? ""):".method
        )
        if self.responds(to: selector) {
            self.perform(selector, with: active)
            return
        }
        log("缺少\(selector)", module: .runtime)
    }
    
    func tapCell(sectionItem: ControlEvent<SectionItem>.Element) {
        guard let host = self.reactor?.host else { return }
        let selector = Selector.init(
            "tap/cell/when/\(host.rawValue)/\(self.reactor?.path?.rawValue ?? ""):".method
        )
        if self.responds(to: selector) {
            self.perform(selector, with: sectionItem)
            return
        }
        log("缺少\(selector)", module: .runtime)
    }
    
    func handleUser(user: User?) {
        guard let host = self.reactor?.host else { return }
        let selector = Selector.init(
            "handle/user/when/\(host.rawValue)/\(self.reactor?.path?.rawValue ?? ""):".method
        )
        if self.responds(to: selector) {
            self.perform(selector, with: user)
            return
        }
        log("缺少\(selector)", module: .runtime)
    }
    
    func handleIssue(issue: Issue?) {
        guard let host = self.reactor?.host else { return }
        let selector = Selector.init(
            "handle/issue/when/\(host.rawValue)/\(self.reactor?.path?.rawValue ?? ""):".method
        )
        if self.responds(to: selector) {
            self.perform(selector, with: issue)
            return
        }
        log("缺少\(selector)", module: .runtime)
    }
    
    override func description(
        forEmptyDataSet scrollView: UIScrollView!
    ) -> NSAttributedString! {
        if self.reactor?.host == .search &&
            self.reactor?.path == .history {
            return nil
        }
        return super.description(forEmptyDataSet: scrollView)
    }
    
    override func buttonTitle(
        forEmptyDataSet scrollView: UIScrollView!,
        for state: UIControl.State
    ) -> NSAttributedString! {
        if self.reactor?.host == .search &&
            self.reactor?.path == .history {
            return nil
        }
        return super.buttonTitle(forEmptyDataSet: scrollView, for: state)
    }
    
    override func buttonBackgroundImage(
        forEmptyDataSet scrollView: UIScrollView!,
        for state: UIControl.State
    ) -> UIImage! {
        if self.reactor?.host == .search &&
            self.reactor?.path == .history {
            return nil
        }
        return super.buttonBackgroundImage(forEmptyDataSet: scrollView, for: state)
    }
    
}
// swiftlint:enable function_body_length
