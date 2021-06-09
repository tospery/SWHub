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
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.separator
        self.tableView.register(Reusable.themeCell)
        self.tableView.rx.itemSelected
            .subscribeNext(weak: self, type(of: self).tapCell)
            .disposed(by: self.disposeBag)
    }
    
    func bind(reactor: ThemeViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: ThemeViewReactor)
        -> RxTableViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, tableView, indexPath, sectionItem in
                switch sectionItem {
                case .theme(let item):
                    let cell = tableView.dequeue(Reusable.themeCell)!
                    cell.reactor = item
                    return cell
                default:
                    return tableView.emptyCell(for: indexPath)
                }
            }
        )
        
    }
    
}

extension ThemeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.dataSource[indexPath] {
        case let .theme(item):
            return Reusable.themeCell.class.height(item: item)
        default:
            return .zero
        }
    }
    
}
