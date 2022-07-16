//
//  Date.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 16/07/2022.
//

import Foundation

extension Date {
    func asStringWithMediumForrmaterDataStyle() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
