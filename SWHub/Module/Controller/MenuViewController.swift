//
//  MenuViewController.swift
//  SWHub
//
//  Created by liaoya on 2021/5/20.
//

import UIKit

class MenuViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let sinceCell = ReusableCell<SinceCell>()
        static let languageCell = ReusableCell<LanguageCell>()
        static let headerView = ReusableView<MenuHeaderView>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    lazy var bottomView: MenuBottomView = {
        let view = MenuBottomView.init()
        view.sizeToFit()
        return view
    }()
    
    init(_ navigator: NavigatorType, _ reactor: MenuViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        self.hidesNavigationBar = reactor.parameters[Parameter.hideNavBar] as? Bool ?? true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.bottomView)
        self.collectionView.register(Reusable.sinceCell)
        self.collectionView.register(Reusable.languageCell)
        self.collectionView.register(Reusable.headerView, kind: .header)
        self.collectionView.rx.itemSelected(dataSource: self.dataSource)
            .subscribeNext(weak: self, type(of: self).tapCell)
            .disposed(by: self.disposeBag)
//        themeService.rx
//            .bind({ $0.primaryColor }, to: self.collectionView.rx.backgroundColor)
//            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.bottomView.width = self.view.width
        self.bottomView.height = (UIScreen.safeBottom + 50).flat
        self.bottomView.left = 0
        self.bottomView.bottom = self.view.height
        self.collectionView.width = self.view.width
        self.collectionView.height -= self.bottomView.height
    }
    
    func bind(reactor: MenuViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: MenuViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .since(let item):
                    let cell = collectionView.dequeue(Reusable.sinceCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case .language(let item):
                    let cell = collectionView.dequeue(Reusable.languageCell, for: indexPath)
                    cell.reactor = item
                    return cell
                default:
                    return collectionView.emptyCell(for: indexPath)
                }
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    let header = collectionView.dequeue(Reusable.headerView, kind: kind, for: indexPath)
                    reactor.state.map { $0.sections[indexPath.section] }
                        .map { section -> String in
                            switch section {
                            case let .sectionItems(header, _):
                                return header
                            }
                        }
                        .distinctUntilChanged()
                        .bind(to: header.rx.title)
                        .disposed(by: header.disposeBag)
                    return header
                default:
                    return collectionView.emptyView(for: indexPath, kind: kind)
                }
            }
        )
    }
    
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case .since(let item):
            return Reusable.sinceCell.class.size(width: width, item: item)
        case .language(let item):
            return Reusable.languageCell.class.size(width: width, item: item)
        default:
            return .zero
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height = 0.f
        switch section {
        case 0: height = UIScreen.statusBarHeightConstant + 20
        case 1: height = 30
        default: break
        }
        return .init(
            width: collectionView.sectionWidth(at: section),
            height: height
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(horizontal: metric(20), vertical: 0)
    }

}
