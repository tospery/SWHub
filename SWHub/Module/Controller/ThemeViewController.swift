//
//  ThemeViewController.swift
//  SWHub
//
//  Created by liaoya on 2021/5/8.
//

import UIKit

class ThemeViewController: TableViewController, ReactorKit.View {
    
    struct Reusable {
        static let themeCell = ReusableCell<ThemeCell>()
    }

    let dataSource: RxTableViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: ThemeViewReactor) {
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
        self.tableView.register(Reusable.themeCell)
//        self.collectionView.register(Reusable.simpleCell)
//        self.collectionView.register(Reusable.headerView, kind: .header)
//        self.collectionView.rx.itemSelected(dataSource: self.dataSource)
//            .subscribeNext(weak: self, type(of: self).tapCell)
//            .disposed(by: self.disposeBag)
//        themeService.rx
//            .bind({ $0.brightColor }, to: self.collectionView.rx.backgroundColor)
//            .disposed(by: self.rx.disposeBag)
    }
    
//    func tapCell(sectionItem: ControlEvent<SectionItem>.Element) {
//        switch sectionItem {
//        case let .simple(item):
//            guard let simple = item.model as? Simple else { return }
//            guard let portal = AboutViewReactor.Portal.init(rawValue: simple.id) else { return }
//            switch portal {
//            case .share:
////                UMSocialUIManager.setPreDefinePlatforms([
////                    UMSocialPlatformType.wechatSession.rawValue,
////                    UMSocialPlatformType.wechatTimeLine.rawValue
////                ])
////                UMSocialUIManager.showShareMenuViewInWindow { [weak self] (type, _) in
////                    guard let `self` = self else { return }
////                    self.share(to: type)
////                }
//            break
//            default:
//                break
//            }
//        default:
//            break
//        }
//    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: ThemeViewReactor)
        -> RxTableViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, tableView, indexPath, sectionItem in
                switch sectionItem {
                case .theme(let item):
                    let cell = tableView.dequeue(Reusable.themeCell)!
                    cell.bind(reactor: item)
                    return cell
                default:
                    return tableView.emptyCell(for: indexPath)
                }
            }
        )
        
    }
    
}

//extension AboutViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        let width = collectionView.sectionWidth(at: indexPath.section)
//        switch self.dataSource[indexPath] {
//        case .simple(let item):
//            return Reusable.simpleCell.class.size(width: width, item: item)
//        default:
//            return .zero
//        }
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        referenceSizeForHeaderInSection section: Int
//    ) -> CGSize {
//        .init(width: collectionView.sectionWidth(at: section), height: 200)
//    }
//
//}
