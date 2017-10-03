//
//  DIExtension.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 03/10/2017.
//  Copyright © 2017 Alexander Ivlev. All rights reserved.
//

import Foundation

public class DIExtension {
  private let container: DIContainer
  private let bundle: Bundle?
  
  public init(container: DIContainer, bundle: Bundle? = nil) {
    self.container = container
    self.bundle = bundle
  }
  
  public func `for`<T>(_ type: T.Type) -> DIComponentExtension<T> {
    return DIComponentExtension(container.resolver.findComponents(by: type, with: nil, from: bundle))
  }
  
  public func `for`<T, Tag>(_ type: T.Type, tag: Tag.Type) -> DIComponentExtension<T> {
    return DIComponentExtension(container.resolver.findComponents(by: DIByTag<T,Tag>.self, with: nil, from: bundle))
  }
  
  public func `for`<T>(_ type: T.Type, name: String) -> DIComponentExtension<T> {
    return DIComponentExtension(container.resolver.findComponents(by: type, with: name, from: bundle))
  }
}

public class DIComponentExtension<Impl> {
  fileprivate typealias Cache = (initial: MethodSignature?, injections: [Injection], postInit: MethodSignature?)
  fileprivate let components: [Component]
  fileprivate let cache: [Cache]
  
  fileprivate init(_ components: [Component]) {
    self.components = components
    cache = components.map{ ($0.initial, $0.injections, $0.postInit) }
  }
  
  deinit { // return old state
    for (component, cache) in zip(components, cache) {
      component.initial = cache.initial
      component.injections = cache.injections
      component.postInit = cache.postInit
    }
  }
}

public extension DIComponentExtension {
  @discardableResult
  public func postInit(_ method: @escaping (Impl) -> ()) -> Self {
    for component in components {
      component.postInit = MethodMaker.make([UseObject.self], by: method)
    }
    return self
  }
  
  
}
