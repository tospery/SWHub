//
//  SummaryUserItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import Foundation

class SummaryUserItem: BaseCollectionItem, ReactorKit.Reactor {

    enum Action {
        case logined(Bool)
        case avatar(String?)
        case bio(String?)
        case time(String?)
        case name(NSAttributedString?)
        case repositories(NSAttributedString?)
        case followers(NSAttributedString?)
        case following(NSAttributedString?)
    }
    
    enum Mutation {
        case setLogined(Bool)
        case setAvatar(String?)
        case setBio(String?)
        case setTime(String?)
        case setName(NSAttributedString?)
        case setRepositories(NSAttributedString?)
        case setFollowers(NSAttributedString?)
        case setFollowing(NSAttributedString?)
    }

    struct State {
        var isIndicated = false
        var isLogined = false
        var avatar: String?
        var bio: String?
        var time: String?
        var name: NSAttributedString?
        var repositories: NSAttributedString?
        var followers: NSAttributedString?
        var following: NSAttributedString?
    }

    var initialState = State()

    required public init(_ model: ModelType) {
        super.init(model)
        guard let tuple = (model as? BaseModel)?.data as? KVTuple else { return }
        self.initialState = State(
            isIndicated: tuple.value as? Bool ?? false
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .logined(isLogined):
            return .just(.setLogined(isLogined))
        case let .avatar(avatar):
            return .just(.setAvatar(avatar))
        case let .bio(bio):
            return .just(.setBio(bio))
        case let .time(time):
            return .just(.setTime(time))
        case let .name(name):
            return .just(.setName(name))
        case let .repositories(repositories):
            return .just(.setRepositories(repositories))
        case let .followers(followers):
            return .just(.setFollowers(followers))
        case let .following(following):
            return .just(.setFollowing(following))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLogined(isLogined):
            newState.isLogined = isLogined
        case let .setAvatar(avatar):
            newState.avatar = avatar
        case let .setBio(bio):
            newState.bio = bio
        case let .setTime(time):
            newState.time = time
        case let .setName(name):
            newState.name = name
        case let .setRepositories(repositories):
            newState.repositories = repositories
        case let .setFollowers(followers):
            newState.followers = followers
        case let .setFollowing(following):
            newState.following = following
        }
        return newState
    }
    
    func transform(action: Observable<NoAction>) -> Observable<NoAction> {
        action
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        mutation
    }

    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
