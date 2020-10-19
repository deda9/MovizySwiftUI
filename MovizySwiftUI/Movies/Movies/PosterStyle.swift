//
//  PosterStyle.swift
//  Movies
//
//  Created by Deda on 19.10.20.
//

import SwiftUI

struct PosterStyle: ViewModifier {
    let size: Size
    
    func body(content: Content) -> some View {
        content
            .frame(width: self.size.width, height: self.size.height)
            .cornerRadius(4.0)
            .shadow(radius: 4.0)
    }
}

extension PosterStyle {
    enum Size {
        case small
        case medium
        case large
        
        var width: CGFloat {
            switch self {
            case .small:
                return 55
            case .medium:
                return 55 * 2
            case .large:
                return 55 * 3
            }
        }
        
        var height: CGFloat {
            switch self {
            case .small:
                return 80
            case .medium:
                return 80 * 2
            case .large:
                return 80 * 3
            }
        }
    }
}

extension View {
    func posterStyle(size: PosterStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: PosterStyle(size: size))
    }
}
