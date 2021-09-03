//
//  ImageCache.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/18/21.
//

import Foundation

struct Config {
    let countLimit: Int
    let memoryLimit: Int
    static let defaultConfig = Config(countLimit: 50, memoryLimit: 1024 * 1024 * 100) //about 100MB
}
class ImageCache {
    let cache = NSCache<AnyObject, AnyObject>()
    static let shared = ImageCache()
    private init(countLimit: Int, memoryLimit: Int) {
        self.cache.countLimit = countLimit
        self.cache.totalCostLimit = memoryLimit
    }
    
    private init() {
        self.cache.countLimit = Config.defaultConfig.countLimit
        self.cache.totalCostLimit = Config.defaultConfig.memoryLimit
    }
    
}

