//
//  URL+IsDirectory.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/19/23.
//

import Foundation

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}
