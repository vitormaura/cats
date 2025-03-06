import RouterProtocol

protocol DecodableRoute: Route {
    init(from decoder: Decoder, dependencies: Dependencies, associatedTabIndex: Int?) throws
}
