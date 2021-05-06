//
//  AboutViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/6.
//

import UIKit

class AboutViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let simpleCell = ReusableCell<SimpleCell>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: AboutViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.simpleCell)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: AboutViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .simple(let item):
                    let cell = collectionView.dequeue(Reusable.simpleCell, for: indexPath)
                    cell.bind(reactor: item)
                    return cell
                default:
                    return collectionView.emptyCell(for: indexPath)
                }
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                return collectionView.emptyView(for: indexPath, kind: kind)
            }
        )
    }
    
}

extension AboutViewController: UICollectionViewDelegateFlowLayout {

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
            return .zero
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
