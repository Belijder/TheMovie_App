//
//  WatchlistShape.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 19/03/2022.
//

import SwiftUI

struct WatchlistShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.height * 0.8))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
