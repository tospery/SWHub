//
//  ListViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/21.
//

import UIKit
import Parchment

// swiftlint:disable type_body_length function_body_length cyclomatic_complexity
class ListViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let simpleCell = ReusableCell<SimpleCell>()
        static let repoCell = ReusableCell<RepoCell>()
        static let repoSummaryCell = ReusableCell<SummaryRepoCell>()
        static let trendingUserCell = ReusableCell<TrendingUserCell>()
        static let readmeContentCell = ReusableCell<ReadmeContentCell>()
        static let readmeRefreshCell = ReusableCell<ReadmeRefreshCell>()
        static let issueCell = ReusableCell<IssueCell>()
        static let schemeCell = ReusableCell<SchemeCell>()
        static let logoutCell = ReusableCell<LogoutCell>()
        static let textFieldCell = ReusableCell<TextFieldCell>()
        static let textViewCell = ReusableCell<TextViewCell>()
        static let buttonCell = ReusableCell<ButtonCell>()
        static let userTopCell = ReusableCell<SummaryUserCell>()
        static let appCell = ReusableCell<AppCell>()
        static let feedbackInputCell = ReusableCell<FeedbackInputCell>()
        static let feedbackNoteCell = ReusableCell<FeedbackNoteCell>()
        static let searchHistoryCell = ReusableCell<SearchHistoryCell>()
        static let searchUserCell = ReusableCell<SearchUserCell>()
        static let emptyCell = ReusableCell<EmptyCell>()
        static let headerView = ReusableView<BaseSupplementaryView>()
        static let footerView = ReusableView<BaseSupplementaryView>()
    }

    var searchBar: UISearchBar?
    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: ListViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        self.tabBarItem.title = reactor.currentState.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.reactor?.host {
        case .search:
            self.navigationBar.removeAllLeftButtons()
            let searchBar = UISearchBar.init(frame: self.navigationBar.bounds)
            searchBar.delegate = self
            searchBar.showsCancelButton = true
            searchBar.textField?.font = .normal(15)
            searchBar.placeholder = R.string.localizable.tipsSearch()
            searchBar.backgroundImage = UIImage.init()
            searchBar.becomeFirstResponder()
            searchBar.sizeToFit()
            themeService.rx
                .bind({ $0.brightColor }, to: searchBar.rx.barTintColor)
                .disposed(by: self.rx.disposeBag)
            self.navigationBar.titleView = searchBar
            self.searchBar = searchBar
        default:
            break
        }
        
        self.collectionView.register(Reusable.simpleCell)
        self.collectionView.register(Reusable.repoCell)
        self.collectionView.register(Reusable.repoSummaryCell)
        self.collectionView.register(Reusable.trendingUserCell)
        self.collectionView.register(Reusable.readmeContentCell)
        self.collectionView.register(Reusable.readmeRefreshCell)
        self.collectionView.register(Reusable.issueCell)
        self.collectionView.register(Reusable.schemeCell)
        self.collectionView.register(Reusable.logoutCell)
        self.collectionView.register(Reusable.userTopCell)
        self.collectionView.register(Reusable.appCell)
        self.collectionView.register(Reusable.textFieldCell)
        self.collectionView.register(Reusable.textViewCell)
        self.collectionView.register(Reusable.buttonCell)
        self.collectionView.register(Reusable.feedbackInputCell)
        self.collectionView.register(Reusable.feedbackNoteCell)
        self.collectionView.register(Reusable.searchHistoryCell)
        self.collectionView.register(Reusable.searchUserCell)
        self.collectionView.register(Reusable.emptyCell)
        self.collectionView.register(Reusable.headerView, kind: .header)
        self.collectionView.register(Reusable.footerView, kind: .footer)
        self.collectionView.rx.itemSelected(dataSource: self.dataSource)
            .subscribeNext(weak: self, type(of: self).tapCell)
            .disposed(by: self.disposeBag)
        
        themeService.rx
            .bind({ $0.brightColor }, to: self.collectionView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        switch self.reactor?.host {
        case .users, .repos:
            switch self.reactor?.path {
            case .trending, .search:
                self.collectionView.frame = self.view.bounds
            default:
                break
            }
        default:
            break
        }
    }

    func bind(reactor: ListViewReactor) {
        super.bind(reactor: reactor)
        self.toAction(reactor: reactor)
        self.fromState(reactor: reactor)
    }
    
    static func dataSourceFactory(
        _ navigator: NavigatorType,
        _ reactor: ListViewReactor) -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case let .simple(item):
                    let cell = collectionView.dequeue(Reusable.simpleCell, for: indexPath)
                    if reactor.host == .user ||
                        reactor.host == .profile ||
                        reactor.host == .center ||
                        reactor.host == .repo {
                        item.parent = reactor
                    }
                    cell.reactor = item
                    return cell
                case let .repo(item):
                    let cell = collectionView.dequeue(Reusable.repoCell, for: indexPath)
                    cell.reactor = item
                    cell.rx.tapUser.subscribe(onNext: { username in
                        navigator.push(
                            Router.urlString(host: .user).url!.appendingPathComponent(username)
                        )
                    }).disposed(by: cell.disposeBag)
                    return cell
                case let .trendingUser(item):
                    let cell = collectionView.dequeue(Reusable.trendingUserCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case let .issue(item):
                    let cell = collectionView.dequeue(Reusable.issueCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case let .scheme(item):
                    let cell = collectionView.dequeue(Reusable.schemeCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case let .logout(item):
                    let cell = collectionView.dequeue(Reusable.logoutCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case let .summaryUser(item):
                    let cell = collectionView.dequeue(Reusable.userTopCell, for: indexPath)
                    item.parent = reactor
                    cell.reactor = item
                    cell.rx.login.subscribe(onNext: { _ in
                        navigator.present(Router.urlString(host: .login), wrap: NavigationController.self)
                    }).disposed(by: cell.disposeBag)
                    return cell
                case let .summaryRepo(item):
                    let cell = collectionView.dequeue(Reusable.repoSummaryCell, for: indexPath)
                    item.parent = reactor
                    cell.reactor = item
                    return cell
                case let .app(item):
                    let cell = collectionView.dequeue(Reusable.appCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case let .textField(item):
                    let cell = collectionView.dequeue(Reusable.textFieldCell, for: indexPath)
                    cell.reactor = item
                    cell.rx.text
                        .distinctUntilChanged()
                        .skip(1)
                        .map { Reactor.Action.value($0) }
                        .observeOn(MainScheduler.asyncInstance)
                        .bind(to: reactor.action)
                        .disposed(by: cell.disposeBag)
                    return cell
                case let .textView(item):
                    let cell = collectionView.dequeue(Reusable.textViewCell, for: indexPath)
                    cell.reactor = item
                    cell.rx.text
                        .distinctUntilChanged()
                        .skip(1)
                        .map { Reactor.Action.value($0) }
                        .observeOn(MainScheduler.asyncInstance)
                        .bind(to: reactor.action)
                        .disposed(by: cell.disposeBag)
                    return cell
                case let .button(item):
                    let cell = collectionView.dequeue(Reusable.buttonCell, for: indexPath)
                    cell.reactor = item
                    cell.rx.tap.map { Reactor.Action.activate(nil) }
                        .bind(to: reactor.action)
                        .disposed(by: cell.disposeBag)
                    return cell
                case let .feedbackInput(item):
                    let cell = collectionView.dequeue(Reusable.feedbackInputCell, for: indexPath)
                    cell.reactor = item
                    Observable<String?>.combineLatest([
                        item.state.map { $0.title },
                        cell.rx.body.asObservable()
                    ])
                    .distinctUntilChanged()
                    .map { Reactor.Action.value($0) }
                    .observeOn(MainScheduler.asyncInstance)
                    .bind(to: reactor.action)
                    .disposed(by: cell.disposeBag)
                    return cell
                case let .feedbackNote(item):
                    let cell = collectionView.dequeue(Reusable.feedbackNoteCell, for: indexPath)
                    cell.reactor = item
                    cell.rx.issues.subscribe(onNext: { _ in
                        navigator.push(
                            Router.urlString(host: .repo).url!
                                .appendingPathComponent(Author.username)
                                .appendingPathComponent(Author.reponame)
                        )
                    }).disposed(by: cell.disposeBag)
                    return cell
                case let .searchHistory(item):
                    let cell = collectionView.dequeue(Reusable.searchHistoryCell, for: indexPath)
                    cell.reactor = item
                    cell.rx.clear.subscribe(onNext: { _ in
                        SearchHistory.eraseObject()
                        reactor.action.onNext(.load)
                    }).disposed(by: cell.disposeBag)
                    cell.rx.word.map { Reactor.Action.activate($0) }
                        .bind(to: reactor.action)
                        .disposed(by: cell.disposeBag)
                    return cell
                case let .searchUser(item):
                    let cell = collectionView.dequeue(Reusable.searchUserCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case let .readmeRefresh(item):
                    let cell = collectionView.dequeue(Reusable.readmeRefreshCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case let .readmeContent(item):
                    let cell = collectionView.dequeue(Reusable.readmeContentCell, for: indexPath)
                    item.parent = reactor
                    cell.reactor = item
                    return cell
                case let .empty(item):
                    let cell = collectionView.dequeue(Reusable.emptyCell, for: indexPath)
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
                    themeService.rx
                        .bind({ $0.brightColor }, to: header.rx.backgroundColor)
                        .disposed(by: header.rx.disposeBag)
                    return header
                case UICollectionView.elementKindSectionFooter:
                    let footer = collectionView.dequeue(Reusable.footerView, kind: kind, for: indexPath)
                    themeService.rx
                        .bind({ $0.brightColor }, to: footer.rx.backgroundColor)
                        .disposed(by: footer.rx.disposeBag)
                    return footer
                default:
                    return collectionView.emptyView(for: indexPath, kind: kind)
                }
            }
        )
    }
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case let .simple(item): return Reusable.simpleCell.class.size(width: width, item: item)
        case let .repo(item): return Reusable.repoCell.class.size(width: width, item: item)
        case let .trendingUser(item): return Reusable.trendingUserCell.class.size(width: width, item: item)
        case let .issue(item): return Reusable.issueCell.class.size(width: width, item: item)
        case let .scheme(item): return Reusable.schemeCell.class.size(width: width, item: item)
        case let .logout(item): return Reusable.logoutCell.class.size(width: width, item: item)
        case let .summaryUser(item): return Reusable.userTopCell.class.size(width: width, item: item)
        case let .summaryRepo(item): return Reusable.repoSummaryCell.class.size(width: width, item: item)
        case let .app(item): return Reusable.appCell.class.size(width: width, item: item)
        case let .textField(item): return Reusable.textFieldCell.class.size(width: width, item: item)
        case let .textView(item): return Reusable.textViewCell.class.size(width: width, item: item)
        case let .feedbackInput(item): return Reusable.feedbackInputCell.class.size(width: width, item: item)
        case let .button(item): return Reusable.buttonCell.class.size(width: width, item: item)
        case let .feedbackNote(item): return Reusable.feedbackNoteCell.class.size(width: width, item: item)
        case let .readmeRefresh(item): return Reusable.readmeRefreshCell.class.size(width: width, item: item)
        case let .readmeContent(item): return Reusable.readmeContentCell.class.size(width: width, item: item)
        case let .searchHistory(item): return Reusable.searchHistoryCell.class.size(width: width, item: item)
        case let .searchUser(item): return Reusable.searchUserCell.class.size(width: width, item: item)
        case let .empty(item): return Reusable.emptyCell.class.size(width: width, item: item)
        default: return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        switch self.reactor?.host {
        case .modify, .feedback:
            return 20
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        switch self.reactor?.host {
        case .user, .repo, .center:
            return .init(width: collectionView.sectionWidth(at: section), height: (section == 0 ? 0 : 15))
        case .profile:
            switch section {
            case 2:
                return .init(width: collectionView.sectionWidth(at: section), height: 30)
            default:
                return .init(width: collectionView.sectionWidth(at: section), height: 15)
            }
        case .modify, .feedback:
            return .init(width: collectionView.sectionWidth(at: section), height: 10)
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        switch self.reactor?.host {
        case .repo:
            return .init(
                width: collectionView.sectionWidth(at: section),
                height: (section == 2 ? 20 + UIScreen.safeBottom : 0)
            )
        default:
            return .zero
        }
    }

}
// swiftlint:enable type_body_length function_body_length cyclomatic_complexity
