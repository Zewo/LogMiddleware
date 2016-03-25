// LogMiddleware.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
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

@_exported import Log
@_exported import HTTP

public struct LogMiddleware: Middleware {
    private let log: Log
    private let level: Log.Level
    private let debug: Bool

    public init(log: Log, level: Log.Level = .Info, debug: Bool = true) {
        self.log = log
        self.level = level
        self.debug = debug
    }

    public func respond(request: Request, chain: Responder) throws -> Response {
        let response = try chain.respond(request)
        var message = "================================================================================\n"
        message += "Request:\n"
        message += debug ? "\(request.debugDescription)\n" : "\(request)\n"
        message += "--------------------------------------------------------------------------------\n"
        message += "Response:\n"
        message += debug ? "\(response.debugDescription)\n" : "\(response)\n"
        message += "================================================================================\n\n"
        log.log(level, item: message)
        return response
    }
}
