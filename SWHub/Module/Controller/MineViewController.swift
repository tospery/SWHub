//
//  MineViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class MineViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let simpleCell = ReusableCell<SimpleCell>()
        static let headerView = ReusableView<MineHeaderView>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: MineViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        // self.hidesNavigationBar = reactor.parameters[Parameter.hideNavBar] as? Bool ?? true
        self.transparetNavBar = reactor.parameters[Parameter.transparetNavBar] as? Bool ?? true
        // self.tr = reactor.parameters[Parameter.hideNavLine] as? Bool ?? true
        self.tabBarItem.title = reactor.currentState.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.addButtonToRight(R.image.setting()).rx.tap
            .subscribeNext(weak: self, type(of: self).tapSetting)
            .disposed(by: self.disposeBag)
        self.collectionView.register(Reusable.simpleCell)
        self.collectionView.register(Reusable.headerView, kind: .header)
//        self.view.addSubview(self.testButton)
//        self.testButton.left = 100
//        self.testButton.top = 100
//        self.testButton.rx.tap
//            .subscribeNext(weak: self, type(of: self).tapTest)
//            .disposed(by: self.disposeBag)
    }
    
    func bind(reactor: MineViewReactor) {
        super.bind(reactor: reactor)
        // action
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        // state
//        reactor.state.map { $0.title }
//            .distinctUntilChanged()
//            .bind(to: self.navigationBar.titleLabel.rx.text)
//            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading())
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.sections }
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
    func tapSetting(event: ControlEvent<Void>.Element) {
        themeService.switch(.dark)
        // self.navigator.present(Router.login.urlString, wrap: NavigationController.self)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: MineViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .simple(let item):
                    let cell = collectionView.dequeue(Reusable.simpleCell, for: indexPath)
                    cell.bind(reactor: item)
                    return cell
                default:
                    fatalError()
                }
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    let header = collectionView.dequeue(Reusable.headerView, kind: kind, for: indexPath)
                    reactor.state.map { $0.user }
                        .bind(to: header.rx.user)
                        .disposed(by: header.disposeBag)
//                    header.rx.pay.flatMap { _ -> Observable<Void> in
//                        return self.loginIfNeed(reactor, navigator, header.disposeBag) ? .empty() : .just(())
//                    }.subscribe(onNext: { _ in
//                        navigator.push(Webpage.pay.urlString)
//                    }).disposed(by: header.disposeBag)
                    return header
//                case UICollectionView.elementKindSectionFooter:
//                    return collectionView.emptyView(for: indexPath, kind: kind)
                default:
                    return collectionView.emptyView(for: indexPath, kind: kind)
                }
            }
        )
    }
    
}

extension MineViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case .simple(let item):
            return Reusable.simpleCell.class.size(width: width, item: item)
        default:
            fatalError()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        .init(width: collectionView.sectionWidth(at: section), height: 280)
    }
    
}
