//
//  TrendingUsersViewController.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import UIKit

class TrendingUsersViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let userCell = ReusableCell<UserCell>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: TrendingUsersViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        self.hidesNavigationBar = reactor.parameters[Parameter.hideNavBar] as? Bool ?? true
        self.shouldRefresh = reactor.parameters[Parameter.shouldRefresh] as? Bool ?? true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.userCell)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: TrendingUsersViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .user(let item):
                    let cell = collectionView.dequeue(Reusable.userCell, for: indexPath)
                    cell.bind(reactor: item)
                    return cell
                default:
                    fatalError()
                }
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                return collectionView.emptyView(for: indexPath, kind: kind)
            }
        )
    }
    
}

extension TrendingUsersViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case .user(let item):
            return Reusable.userCell.class.size(width: width, item: item)
        default:
            fatalError()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        .zero
    }

}
