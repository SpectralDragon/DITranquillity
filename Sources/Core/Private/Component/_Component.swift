//
//  _Component.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 18/07/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

class _Component {
  typealias UniqueKey = String
  
  init(componentInfo: DI.ComponentInfo) {
    self.componentInfo = componentInfo
    self.uniqueKey = "\(componentInfo.type)\(componentInfo.file)\(componentInfo.line)"
  }

  let componentInfo: DI.ComponentInfo
  let uniqueKey: UniqueKey
}

extension _Component: Hashable {
  var hashValue: Int { return uniqueKey.hash }
  
  static func == (lhs: _Component, rhs: _Component) -> Bool {
    return lhs.uniqueKey == rhs.uniqueKey
  }
}