//
//  String.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 01/07/2022.
//

import Foundation

extension String {
    func first4characters() -> String {
        String(self.prefix(4))
    }
    
    func asDateLikeStyle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date ?? Date.now)
        
        
        
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: date)
//        let finalDate = calendar.date(from: components)
    }
}
