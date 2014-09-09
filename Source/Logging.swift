// Logging.swift
//
// Copyright (c) 2014 Shintaro Kaneko (http://kaneshinth.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public enum LogLevel: Int {
    case Verbose
    case Debug
    case Info
    case Warn
    case Error
    var tag: String {
        switch self {
        case .Verbose:
            return "VERBOSE"
        case .Debug:
            return "DEBUG"
        case .Info:
            return "INFO"
        case .Warn:
            return "WARN"
        case .Error:
            return "ERROR"
        default:
            return "LOG"
            }
    }
}

public struct Component {
    var location: String = __FUNCTION__
    var line: Int = __LINE__
}

// MARK: - Driver

public class Driver {
    
}

// MARK: - Manager

public class Manager {
    
    public class var sharedInstance: Manager {
        struct Singleton {
            static let instance = Manager()
        }
        return Singleton.instance
    }
    
    var level: LogLevel = LogLevel.Info
    var location: Bool = true
    var line: Bool = true
    
    public func println(level: LogLevel, message: String, component: Component) {
        if self.level.toRaw() > level.toRaw() {
            return
        }
        var output: String = ""
        if location {
            output += "[\(component.location)]"
        }
        if line {
            output += "[Line \(component.line)]"
        }
        output += "[\(level.tag)] \(message)"
        Swift.println(output)
    }
    
}

// MARK: - Setup

public func setLogLevel(level: LogLevel) {
    Manager.sharedInstance.level = level
}

public func includeLocation(location: Bool) {
    Manager.sharedInstance.location = location
}

public func includeLine(line: Bool) {
    Manager.sharedInstance.line = line
}

// MARK: - Useful
    
public func verbose(message: String, component: Component = Component()) {
    Manager.sharedInstance.println(LogLevel.Verbose, message: message, component: component)
}

public func debug(message: String, component: Component = Component()) {
    Manager.sharedInstance.println(LogLevel.Debug, message: message, component: component)
}

public func info(message: String, component: Component = Component()) {
    Manager.sharedInstance.println(LogLevel.Info, message: message, component: component)
}

public func warn(message: String, component: Component = Component()) {
    Manager.sharedInstance.println(LogLevel.Warn, message: message, component: component)
}

public func error(message: String, component: Component = Component()) {
    Manager.sharedInstance.println(LogLevel.Error, message: message, component: component)
}
