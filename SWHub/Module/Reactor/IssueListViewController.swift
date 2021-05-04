//
//  IssueListViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/3.
//

import UIKit

class IssueListViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let issueCell = ReusableCell<IssueCell>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: IssueListViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        self.shouldRefresh = reactor.parameters[Parameter.shouldRefresh] as? Bool ?? true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.issueCell)
        self.collectionView.rx.itemSelected(dataSource: self.dataSource)
            .subscribeNext(weak: self, type(of: self).tapCell)
            .disposed(by: self.disposeBag)
    }

    func tapCell(sectionItem: ControlEvent<SectionItem>.Element) {
        switch sectionItem {
        case let .issue(item):
            guard let issue = item.model as? Issue else { return }
            guard let urlString = issue.htmlUrl else { return }
            self.navigator.push(urlString)
        default:
            break
        }
    }
    
    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: IssueListViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .issue(let item):
                    let cell = collectionView.dequeue(Reusable.issueCell, for: indexPath)
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

extension IssueListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case .issue(let item):
            return Reusable.issueCell.class.size(width: width, item: item)
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
