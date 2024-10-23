//
//  4.HeritageProtocols.swift
//  Sandbox
//
//  Created by Maxence Mottard on 21/10/2024.
//

import Foundation

protocol Prot1 {
    var test: String { get }
}

protocol Prot2: Prot1 {

}

extension Prot2 {
    var test: String {
        "Bonjour"
    }
}

struct Test: Prot2 {

}
