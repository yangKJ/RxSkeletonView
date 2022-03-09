//
//  SkeletonSection.swift
//  RxSkeletonView_Example
//
//  Created by Condy on 2022/2/5.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import RxSkeletonView

enum SkeletonSectionItem {
    case asset(item: String)
    case token(item: String)
    
    var itemHeight: CGFloat {
        switch self {
        case .asset:
            return 200
        case .token:
            return 70 + 12
        }
    }
}

extension SkeletonSectionItem: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: Identity {
        switch self {
        case .asset:
            return "asset"
        case .token:
            return "token"
        }
    }
}

enum SkeletonSection {
    case asset(items: [SkeletonSectionItem])
    case token(items: [SkeletonSectionItem])
}

extension SkeletonSection: AnimatableSectionModelType {
    typealias Item = SkeletonSectionItem
    typealias Identity = String
    
    var identity: String {
        return "od"
    }
    
    var items: [SkeletonSectionItem] {
        switch self {
        case .asset(let items):
            return items
        case .token(let items):
            return items
        }
    }
    
    init(original: SkeletonSection, items: [SkeletonSectionItem]) {
        switch original {
        case .asset:
            self = SkeletonSection.asset(items: items)
        case .token:
            self = SkeletonSection.token(items: items)
        }
    }
}
