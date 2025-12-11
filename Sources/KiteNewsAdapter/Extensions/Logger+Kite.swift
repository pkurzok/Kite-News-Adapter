//
//  Logger+Kite.swift
//  KiteNewsAdapter
//
//  Created by Peter Kurzok on 11.12.25.
//

import OSLog

extension Logger {
    private static let subsystem = "Kite News Adapter"

    static let kite = Logger(subsystem: subsystem, category: "Kite")
}
