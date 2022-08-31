//
//  MD5Toolkit.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation
import CommonCrypto

class MD5Toolkit: MD5ToolkitProtocol {
    
    func getMd5String(_ source: String) -> String {
        let digest = source.utf8.md5
        return digest.rawValue
    }
}

/// From https://github.com/NikolaiRuhe/SwiftDigest/blob/master/SwiftDigest/MD5Digest.swift
public extension Sequence where Element == UInt8 {

    /// Computes md5 digest value of contained bytes.
    ///
    /// This extension on `Sequence` is the main API to create `MD5Digest` values.
    /// It is usable on all collection types that use bytes as elements, for instance
    /// `Data` or `String.UTF8View`:
    ///
    /// ## Example:
    ///
    /// Print the md5 of a string's UTF-8 representation
    ///
    ///     let string = "The quick brown fox jumps over the lazy dog"
    ///     print("md5: \(string.utf8.md5)")
    ///     // prints "md5: 9e107d9d372bb6826bd81d3542a419d6"
    ///
    /// Check if a file's contents match a digest
    ///
    ///     let expectedDigest = MD5Digest(rawValue: "9e107d9d372bb6826bd81d3542a419d6")!
    ///     let data = try Data(contentsOf: someFileURL)
    ///     if data.md5 != expectedDigest {
    ///         throw .digestMismatchError
    ///     }
    var md5: MD5Digest {
        return MD5Digest(from: Data(self))
    }
}


/// MD5Digest represents a 16 byte digest value, created from hashing arbitrary data.
///
/// MD5Digest is an immutable value type—just like the two `UInt64` values used for
/// internal storage.
///
/// It conforms to ...
///
/// * `Equatable`, to make comparison to other values easy.
/// * `Hashable`, so it can be used as a key in dictionaries or in sets.
/// * `RawRepresentable`, to convert to and from string representations
/// * `CustomStringConvertible`, to make printing easy
/// * `Codable` to enable JSON and Plist coding of types containing a digest property
///
/// - Copyright: Copyright (c) 2017 Nikolai Ruhe.
public struct MD5Digest : Hashable, RawRepresentable, LosslessStringConvertible, Codable {

    private let _digest_0: UInt64
    private let _digest_1: UInt64

    /// Perform hashing of the supplied data.
    public init(from input: Data) {
        (_digest_0, _digest_1) = MD5State(input).digest
    }

    /// Create a digest from reading a hex representation from the supplied string.
    ///
    /// The string _must_ consist of exactly 32 hex digits. Otherwise the initializer
    /// returns `nil`.
    public init?(rawValue: String) {
        self.init(rawValue)
    }

    public init?(_ description: String) {
        guard description.count == 32 else { return nil }
        guard let high = UInt64(description.prefix(16), radix: 16) else { return nil }
        guard let low  = UInt64(description.suffix(16), radix: 16) else { return nil }
        (_digest_0, _digest_1) = (high.byteSwapped, low.byteSwapped)
    }

    public var rawValue: String { return self.description }

    public var description: String {
        return String(format: "%016lx%016lx",
                      _digest_0.byteSwapped,
                      _digest_1.byteSwapped)
    }

    public var data: Data {
        var v = self
        return withUnsafeBytes(of: &v) {
            return Data(bytes: $0.baseAddress!, count: $0.count)
        }
    }

    public var bytes: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8) {
        var v = self
        return withUnsafeBytes(of: &v) {
            (ptr: UnsafeRawBufferPointer) -> (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8) in
            return (ptr[0], ptr[1], ptr[2], ptr[3], ptr[4], ptr[5], ptr[6], ptr[7],
                    ptr[8], ptr[9], ptr[10], ptr[11], ptr[12], ptr[13], ptr[14], ptr[15])
        }
    }
}


/// Pure Swift implementation of the MD5 algorithm.
fileprivate struct MD5State {

    var a = UInt32(0x67452301)
    var b = UInt32(0xefcdab89)
    var c = UInt32(0x98badcfe)
    var d = UInt32(0x10325476)

    static let chunkSize = 64
    static let endOfMessageMarker: UInt8 = 0x80

    /// Compute the md5 of the bytes in `message`.
    init(_ message: Data) {

        // NOTE: A static assert for little endian platform would be great here.
        // Not sure how to do this in Swift, though.
        assert(1.littleEndian == 1 && 2.bigEndian != 2)

        // Feed all complete 64 bytes chunks of the message.
        let remainingByteCount: Int = feedFullChunks(in: message)

        // Copy the remaining bytes into a new chunk sized buffer.
        var chunk = Data(count: MD5State.chunkSize)
        chunk.replaceSubrange(0 ..< remainingByteCount,
                              with: message[(message.count - remainingByteCount)...])

        // Mark the end of message with a single 1 bit.
        chunk[remainingByteCount] = MD5State.endOfMessageMarker

        // If the footer does not fit in the last chunk: feed and clear it.
        if remainingByteCount >= 56 {
            feedFullChunks(in: chunk)
            chunk.resetBytes(in: 0 ..< MD5State.chunkSize)
        }

        // Write the size of the message to the end of the last chunk.
        var len: UInt64 = UInt64(message.count) << 3
        withUnsafeBytes(of: &len) { chunk.replaceSubrange(56 ..< 64, with: $0) }

        // Feed the last chunk.
        feedFullChunks(in: chunk)
    }

    /// Feed all complete 64 byte chunks in the message and return the remaining number of bytes.
    @inline(__always) @discardableResult
    private mutating func feedFullChunks(in message: Data) -> Int {
        let chunkCount = message.count / MD5State.chunkSize
        message.withUnsafeBytes { (pointer: UnsafePointer<UInt32>) -> Void in
            var cursor = pointer
            for _ in 0 ..< chunkCount {
                feed(chunkPointer: &cursor)
            }
        }

        return message.count % MD5State.chunkSize
    }

    var digest: (UInt64, UInt64) {
        let high = UInt64(a) | UInt64(b) << 32
        let low  = UInt64(c) | UInt64(d) << 32
        return (high, low)
    }

    private mutating func feed(chunkPointer ptr: inout UnsafePointer<UInt32>) {

        let old = self

        feed(f0, ptr[00], 0xd76aa478, 07); feed(f0, ptr[01], 0xe8c7b756, 12)
        feed(f0, ptr[02], 0x242070db, 17); feed(f0, ptr[03], 0xc1bdceee, 22)
        feed(f0, ptr[04], 0xf57c0faf, 07); feed(f0, ptr[05], 0x4787c62a, 12)
        feed(f0, ptr[06], 0xa8304613, 17); feed(f0, ptr[07], 0xfd469501, 22)
        feed(f0, ptr[08], 0x698098d8, 07); feed(f0, ptr[09], 0x8b44f7af, 12)
        feed(f0, ptr[10], 0xffff5bb1, 17); feed(f0, ptr[11], 0x895cd7be, 22)
        feed(f0, ptr[12], 0x6b901122, 07); feed(f0, ptr[13], 0xfd987193, 12)
        feed(f0, ptr[14], 0xa679438e, 17); feed(f0, ptr[15], 0x49b40821, 22)

        feed(f1, ptr[01], 0xf61e2562, 05); feed(f1, ptr[06], 0xc040b340, 09)
        feed(f1, ptr[11], 0x265e5a51, 14); feed(f1, ptr[00], 0xe9b6c7aa, 20)
        feed(f1, ptr[05], 0xd62f105d, 05); feed(f1, ptr[10], 0x02441453, 09)
        feed(f1, ptr[15], 0xd8a1e681, 14); feed(f1, ptr[04], 0xe7d3fbc8, 20)
        feed(f1, ptr[09], 0x21e1cde6, 05); feed(f1, ptr[14], 0xc33707d6, 09)
        feed(f1, ptr[03], 0xf4d50d87, 14); feed(f1, ptr[08], 0x455a14ed, 20)
        feed(f1, ptr[13], 0xa9e3e905, 05); feed(f1, ptr[02], 0xfcefa3f8, 09)
        feed(f1, ptr[07], 0x676f02d9, 14); feed(f1, ptr[12], 0x8d2a4c8a, 20)

        feed(f2, ptr[05], 0xfffa3942, 04); feed(f2, ptr[08], 0x8771f681, 11)
        feed(f2, ptr[11], 0x6d9d6122, 16); feed(f2, ptr[14], 0xfde5380c, 23)
        feed(f2, ptr[01], 0xa4beea44, 04); feed(f2, ptr[04], 0x4bdecfa9, 11)
        feed(f2, ptr[07], 0xf6bb4b60, 16); feed(f2, ptr[10], 0xbebfbc70, 23)
        feed(f2, ptr[13], 0x289b7ec6, 04); feed(f2, ptr[00], 0xeaa127fa, 11)
        feed(f2, ptr[03], 0xd4ef3085, 16); feed(f2, ptr[06], 0x04881d05, 23)
        feed(f2, ptr[09], 0xd9d4d039, 04); feed(f2, ptr[12], 0xe6db99e5, 11)
        feed(f2, ptr[15], 0x1fa27cf8, 16); feed(f2, ptr[02], 0xc4ac5665, 23)

        feed(f3, ptr[00], 0xf4292244, 06); feed(f3, ptr[07], 0x432aff97, 10)
        feed(f3, ptr[14], 0xab9423a7, 15); feed(f3, ptr[05], 0xfc93a039, 21)
        feed(f3, ptr[12], 0x655b59c3, 06); feed(f3, ptr[03], 0x8f0ccc92, 10)
        feed(f3, ptr[10], 0xffeff47d, 15); feed(f3, ptr[01], 0x85845dd1, 21)
        feed(f3, ptr[08], 0x6fa87e4f, 06); feed(f3, ptr[15], 0xfe2ce6e0, 10)
        feed(f3, ptr[06], 0xa3014314, 15); feed(f3, ptr[13], 0x4e0811a1, 21)
        feed(f3, ptr[04], 0xf7537e82, 06); feed(f3, ptr[11], 0xbd3af235, 10)
        feed(f3, ptr[02], 0x2ad7d2bb, 15); feed(f3, ptr[09], 0xeb86d391, 21)

        (a, b, c, d) = (a &+ old.a, b &+ old.b, c &+ old.c, d &+ old.d)

        ptr = ptr.advanced(by: 16)
    }

    private var f0: UInt32 { return (b & c) | (~b & d) }
    private var f1: UInt32 { return (d & b) | (~d & c) }
    private var f2: UInt32 { return b ^ c ^ d }
    private var f3: UInt32 { return c ^ (b | ~d) }

    @inline(__always)
    private mutating func feed(_ f: UInt32, _ input: UInt32, _ magic: UInt32, _ shift: Int) {
        let s = a &+ input &+ magic &+ f
        let r = (s << shift) | (s >> (32 - shift))
        (a, b, c, d) = (d, b &+ r, b, c)
    }
}
