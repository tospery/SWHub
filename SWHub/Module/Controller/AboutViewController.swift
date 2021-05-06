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
        static let headerView = ReusableView<AboutHeaderView>()
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
        self.collectionView.register(Reusable.headerView, kind: .header)
        self.collectionView.rx.itemSelected(dataSource: self.dataSource)
            .subscribeNext(weak: self, type(of: self).tapCell)
            .disposed(by: self.disposeBag)
        themeService.rx
            .bind({ $0.brightColor }, to: self.collectionView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    func tapCell(sectionItem: ControlEvent<SectionItem>.Element) {
        switch sectionItem {
        case let .simple(item):
            guard let simple = item.model as? Simple else { return }
            guard let portal = AboutViewReactor.Portal.init(rawValue: simple.id) else { return }
            switch portal {
            case .share:
                let messageObject = UMSocialMessageObject.init()
                let shareObject = UMShareWebpageObject.shareObject(withTitle: "标题", descr: "描述", thumImage: R.image.app_icon())
                shareObject?.webpageUrl = "https://github.com/tospery/SWHub"
                messageObject.shareObject = shareObject
                UMSocialManager.default()?.share(to: .wechatSession, messageObject: messageObject, currentViewController: self, completion: { (data, error) in
                    log("分享结果: \(data), \(error)")
                })
            default:
                break
            }
        default:
            break
        }
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
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    return collectionView.dequeue(Reusable.headerView, kind: kind, for: indexPath)
                default:
                    return collectionView.emptyView(for: indexPath, kind: kind)
                }
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
        .init(width: collectionView.sectionWidth(at: section), height: 200)
    }

}
