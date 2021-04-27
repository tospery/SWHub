//
//  TrendingUsersViewController.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import UIKit

class TrendingUsersViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let repoCell = ReusableCell<RepoCell>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: TrendingUsersViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        self.shouldRefresh = reactor.parameters[Parameter.shouldRefresh] as? Bool ?? true
        self.tabBarItem.title = reactor.currentState.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.repoCell)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: TrendingUsersViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .repo(let item):
                    let cell = collectionView.dequeue(Reusable.repoCell, for: indexPath)
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
        case .repo(let item):
            return Reusable.repoCell.class.size(width: width, item: item)
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
