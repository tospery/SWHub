//
//  ListViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/21.
//

import Foundation

class ListViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
        case refresh
        case loadMore
        case since(Since?)
        case language(Language?)
        case value(Any?)
        case data(Data)
        case activate(Any?)
    }

    enum Mutation {
        case setLoading(Bool)
        case setRefreshing(Bool)
        case setLoadingMore(Bool)
        case setActivating(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setSince(Since?)
        case setLanguage(Language?)
        case setUser(User?)
        case setActive(Any?)
        case setValue(Any?)
        case setData(Data)
        case initial([[ModelType]])
        case append([[ModelType]])
    }

    struct State {
        var isLoading = false
        var isRefreshing = false
        var isLoadingMore = false
        var isActivating = false
        var noMoreData = false
        var error: Error?
        var title: String?
        var user: User?
        var active: Any?
        var value: Any?
        var data = Data.init()
        var since: Since?
        var language: Language?
        var models = [[ModelType]].init()
        var additions = [[ModelType]].init()
        var sections = [Section].init()
    }

    struct Data {
        var repo: Repo?
        var readme: Readme?
        var issue: Issue?
        var branches = [Branch].init()
        var pulls = [Pull].init()
        
        init(
            repo: Repo? = nil,
            readme: Readme? = nil,
            issue: Issue? = nil,
            branches: [Branch] = [],
            pulls: [Pull] = []
        ) {
            self.repo = repo
            self.readme = readme
            self.issue = issue
            self.branches = branches
            self.pulls = pulls
        }
    }
    
    enum MutationType: Int {
        case user
        case data
        case initial
        case append
    }
    
    let host: Router.Host
    let path: Router.Path?
    let reponame: String!
    let keyword: String!
    let stateP: SWHub.State
    let sort: Sort
    let order: Order
    let portal: Portal
    var username: String!
    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        // swiftlint:disable force_cast
        self.host = Router.Host.init(rawValue: parameters?[Parameter.host] as! String)!
        // swiftlint:enable force_cast
        self.path = Router.Path.init(rawValue: parameters?[Parameter.path] as? String ?? "")
        self.reponame = parameters?[Parameter.reponame] as? String
        self.keyword = parameters?[Parameter.keyword] as? String
        self.stateP = SWHub.State.init(
            rawValue: parameters?[Parameter.state] as? String ?? ""
        ) ?? .open
        self.sort = Sort.init(
            rawValue: parameters?[Parameter.sort] as? String ?? ""
        ) ?? .stars
        self.order = Order.init(
            rawValue: parameters?[Parameter.order] as? String ?? ""
        ) ?? .desc
        self.portal = Portal.init(
            rawValue: stringMember(parameters, Parameter.portal, nil)?.int ?? 0
        ) ?? .unknown
        super.init(provider, parameters)
        self.username = parameters?[Parameter.username] as? String
        if self.host == .modify,
           self.title == nil {
            self.title = self.portal.title
        }
        self.initialState = State(
            title: self.title,
            value: self.parameters[Parameter.value] as? String
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .value(value):
            return .just(.setValue(value))
        case let .since(since):
            return .just(.setSince(since))
        case let .language(language):
            return .just(.setLanguage(language))
        case let .data(data):
            return .just(.setData(data))
        case .load:
            return self.load()
        case .refresh:
            return self.refresh()
        case .loadMore:
            return self.loadMore()
        case let .activate(data):
            return self.activate(data)
        }
    }
    
    // swiftlint:disable cyclomatic_complexity
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setRefreshing(isRefreshing):
            newState.isRefreshing = isRefreshing
        case let .setLoadingMore(isLoadingMore):
            newState.isLoadingMore = isLoadingMore
        case let .setActivating(isActivating):
            newState.isActivating = isActivating
        case let .setError(error):
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setSince(since):
            newState.since = since
        case let .setLanguage(language):
            newState.language = language
        case let .setValue(value):
            newState.value = value
        case let .setActive(active):
            newState.active = active
        case let .setUser(user):
            newState.user = user
            log("【数据变化】setUser")
            return self.reduce(newState, .user)
        case let .setData(data):
            newState.data = data
            log("【数据变化】setData")
            return self.reduce(newState, .data)
        case let .initial(models):
            newState.models = models
            log("【数据变化】initial")
            return self.reduce(newState, .initial)
        case let .append(models):
            newState.additions = models
            log("【数据变化】append")
            return self.reduce(newState, .append)
        }
        return newState
    }
    // swiftlint:enable cyclomatic_complexity
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        action
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        switch self.host {
        case .user:
            return mutation
        default:
            let user = Subjection.for(User.self)
                .distinctUntilChanged()
                .asObservable()
                .map(Mutation.setUser)
            return .merge(mutation, user)
        }
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }
    
}
