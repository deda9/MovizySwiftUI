//
//  Pagination.swift
//  Common
//
//  Created by Deda on 03.11.20.
//

public protocol Pagination {
    var totalItems: Int { get set }
    var perPage: Int { get }
    var currentPage: Int { get }
    var state: Pager.State { get set }
    var nextPage: Int { get }
    var canLoadMore: Bool { get }
    
    
}

extension Pager {
    public enum State {
        case idle
        case loading
        case finished
    }
}

public class Pager: Pagination {
    
    public var totalItems: Int = 0
    public var perPage: Int = 20
    public var currentPage: Int = 0
    public var state: State = .idle
    
    public var nextPage: Int {
        self.currentPage += 1
        return self.currentPage
    }
    
    public var canLoadMore: Bool {
        guard self.state != .loading else {
            return false
        }
        return self.totalItems >= self.perPage * self.currentPage
    }
    
    public init() {}
}
