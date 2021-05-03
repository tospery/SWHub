//
//  FeedbackViewReactor.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/2.
//

import Foundation

class FeedbackViewReactor: ScrollViewReactor, ReactorKit.Reactor {

    enum Action {
       // case load
        case feedback(String?)
        case submit
    }

    enum Mutation {
        case setLoading(Bool)
        case setFinished(Bool)
        case setTitle(String?)
        case setError(Error?)
        case setFeedback(String?)
        case setUser(User?)
    }

    struct State {
        var isLoading = false
        var isFinished = false
        var title: String?
        var error: Error?
        var feedback: String?
        var subject: String?
        var user: User?
        
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: self.title ?? R.string.localizable.feedback(),
            subject: R.string.localizable.feedbackEnvironment(
                UIDevice.current.modelName,
                UIDevice.current.systemVersion,
                UIApplication.shared.version!,
                UIApplication.shared.buildNumber!
            )
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .feedback(feedback):
            return Observable.concat([
                .just(.setError(nil)),
                .just(.setFeedback(feedback))
            ])
        case .submit:
            guard let subject = self.currentState.subject, !subject.isEmpty else { return .empty() }
            guard let feedback = self.currentState.feedback, !feedback.isEmpty else { return .empty() }
            return Observable.concat([
                .just(.setError(nil)),
                .just(.setLoading(true)),
                self.feedback(subject, feedback),
                .just(.setLoading(false))
            ]).catchError({
                Observable.concat([
                    .just(.setLoading(false)),
                    .just(.setError($0))
                ])
            })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setFinished(isFinished):
            newState.isFinished = isFinished
        case let .setError(error):
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setUser(user):
            newState.user = user
        case let .setFeedback(feedback):
            newState.feedback = feedback
        }
        return newState
    }
    
    func feedback(_ title: String, _ body: String) -> Observable<Mutation> {
        self.provider.feedback(title: title, body: body).asObservable().map { _ in Mutation.setFinished(true) }
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        action
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        mutation
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }
    
}
