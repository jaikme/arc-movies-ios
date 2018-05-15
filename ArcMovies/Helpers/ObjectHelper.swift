//
//  ObjectHelper.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 12/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

/// _With_ establishes a object to be used for the execution of statements,
/// potentially reducing the amount of code that needs to be written.
@discardableResult
internal func With<ObjectTarget>(_ target: inout ObjectTarget, block: (_ target: inout ObjectTarget) -> Void) -> ObjectTarget {
    block(&target)
    return target
}
