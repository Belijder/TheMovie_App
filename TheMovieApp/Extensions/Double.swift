//
//  Double.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/04/2022.
//

import Foundation

extension Double {
    func asStringWith1DecimalPlace() -> String {
        return String(format: "%.1f", self)
    }
}
