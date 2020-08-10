//
//  Subject.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/10.
//

import Foundation

enum Subject: String, CaseIterable, Identifiable {
    case all
    case physics
    case chemistry
    case biology
    
    func description() -> String {
        switch self {
        case .all:
            return "全部"
        case .physics:
            return "物理"
        case .chemistry:
            return "化学"
        case .biology:
            return "生物"
        }
    }
    
    var id: String { self.rawValue }
}
