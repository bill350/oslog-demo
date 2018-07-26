// The MIT License (MIT)
//
// Copyright (c) 2018 Jean-Charles SORIN
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import SwiftyBeaver

// direct access to the logger across the app
let logger = SwiftyBeaver.self

extension SwiftyBeaver {
  
  static func setupConsole() {
    let console = ConsoleDestination()
    console.levelColor.verbose = "⚪️ "
    console.levelColor.debug = "☑️ "
    console.levelColor.info = "🔵 "
    console.levelColor.warning = "🔶 "
    console.levelColor.error = "🔴 "
    #if DEBUG
    console.minLevel = .verbose
    #else
    console.minLevel = .error
    #endif
    logger.addDestination(console)
  }

  static func fileNameOfFile(_ file: String) -> String {
    let fileParts = file.components(separatedBy: "/")
    if let lastPart = fileParts.last {
      return lastPart
    }
    return ""
  }
  
}

// MARK: OSLog extension
extension SwiftyBeaver {
  
  private static var osLogDestination: OSLogDestination = {
    #if DEBUG
    let level: SwiftyBeaver.Level = .verbose
    #else
    let level: SwiftyBeaver.Level = .error
    #endif
    let osLogDestination = OSLogDestination(level: level)
    return osLogDestination
  }()
  
  static func setOSLog(enabled: Bool) {
    if enabled {
      logger.addDestination(SwiftyBeaver.osLogDestination)
    } else {
      logger.removeDestination(SwiftyBeaver.osLogDestination)
    }
  }

}
