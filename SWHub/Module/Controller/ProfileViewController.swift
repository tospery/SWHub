//
//  ProfileViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/9.
//

import UIKit

class ProfileViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let simpleCell = ReusableCell<SimpleCell>()
        static let headerView = ReusableView<BaseSupplementaryView>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: ProfileViewReactor) {
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
        self.collectionView.register(Reusable.headerView, kind: .header)
        self.collectionView.rx.itemSelected(dataSource: self.dataSource)
            .subscribeNext(weak: self, type(of: self).tapCell)
            .disposed(by: self.disposeBag)
        themeService.rx
            .bind({ $0.brightColor }, to: self.collectionView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    func tapCell(sectionItem: ControlEvent<SectionItem>.Element) {
//        switch sectionItem {
//        case let .simple(item):
//            guard let simple = item.model as? Simple else { return }
//            guard let portal = AboutViewReactor.Portal.init(rawValue: simple.id) else { return }
//            switch portal {
//            case .share:
//                UMSocialUIManager.setPreDefinePlatforms([
//                    UMSocialPlatformType.wechatSession.rawValue,
//                    UMSocialPlatformType.wechatTimeLine.rawValue
//                ])
//                UMSocialUIManager.showShareMenuViewInWindow { [weak self] (type, _) in
//                    guard let `self` = self else { return }
//                    self.share(to: type)
//                }
//            default:
//                break
//            }
//        default:
//            break
//        }
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: ProfileViewReactor)
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
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    let header = collectionView.dequeue(Reusable.headerView, kind: kind, for: indexPath)
                    themeService.rx
                        .bind({ $0.brightColor }, to: header.rx.backgroundColor)
                        .disposed(by: header.rx.disposeBag)
                    return header
                default:
                    return collectionView.emptyView(for: indexPath, kind: kind)
                }
            }
        )
    }
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {

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
        .init(width: collectionView.sectionWidth(at: section), height: 20)
    }

}
