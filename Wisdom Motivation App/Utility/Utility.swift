//
//  Utility.swift
//  Wisdom Motivation App
//
//  Created by Richard Lam on 12/5/2022.
//

import Foundation

func separateFields(line : String) -> [String] {
    
    var results : [String] = []
    
    if line.contains(",\"") {
        let startContentIndex = line.range(of: ",\"")?.upperBound
        let endContentIndex = line.range(of: "\",")?.lowerBound
        let contentEndIndex = line.index(endContentIndex!, offsetBy: -1)
        let authorIndex = line.index(endContentIndex!, offsetBy: +2)
        let contentString = line[startContentIndex!...contentEndIndex]
        
        let components = line.components(separatedBy: ",")
        let authorContent = line[authorIndex...]
        
        results.append(components[0])
        results.append(String(contentString))
        results.append(String(authorContent))
        return results
    } else {
        let components = line.components(separatedBy: ",")
        return components
    }

}


func generateTextFields(content : String) -> [String] {
    let fields: [String] = content.components(separatedBy: "<br>")  as [String]
    return fields
}
