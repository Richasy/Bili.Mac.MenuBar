// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: bilibili/metadata/locale/locale.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// Defined by https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html
struct Bilibili_Metadata_Locale_LocaleIds {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// A language designator is a code that represents a language.
  var language: String = String()

  /// Writing systems.
  var script: String = String()

  /// A region designator is a code that represents a country or an area.
  var region: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// 区域标识
/// gRPC头部:x-bili-locale-bin
struct Bilibili_Metadata_Locale_Locale {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// App设置的locale
  var cLocale: Bilibili_Metadata_Locale_LocaleIds {
    get {return _cLocale ?? Bilibili_Metadata_Locale_LocaleIds()}
    set {_cLocale = newValue}
  }
  /// Returns true if `cLocale` has been explicitly set.
  var hasCLocale: Bool {return self._cLocale != nil}
  /// Clears the value of `cLocale`. Subsequent reads from it will return its default value.
  mutating func clearCLocale() {self._cLocale = nil}

  /// 系统默认的locale
  var sLocale: Bilibili_Metadata_Locale_LocaleIds {
    get {return _sLocale ?? Bilibili_Metadata_Locale_LocaleIds()}
    set {_sLocale = newValue}
  }
  /// Returns true if `sLocale` has been explicitly set.
  var hasSLocale: Bool {return self._sLocale != nil}
  /// Clears the value of `sLocale`. Subsequent reads from it will return its default value.
  mutating func clearSLocale() {self._sLocale = nil}

  /// sim卡的国家码+运营商码
  var simCode: String = String()

  /// 时区
  var timezone: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _cLocale: Bilibili_Metadata_Locale_LocaleIds? = nil
  fileprivate var _sLocale: Bilibili_Metadata_Locale_LocaleIds? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Bilibili_Metadata_Locale_LocaleIds: @unchecked Sendable {}
extension Bilibili_Metadata_Locale_Locale: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "bilibili.metadata.locale"

extension Bilibili_Metadata_Locale_LocaleIds: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".LocaleIds"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "language"),
    2: .same(proto: "script"),
    3: .same(proto: "region"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.language) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.script) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.region) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.language.isEmpty {
      try visitor.visitSingularStringField(value: self.language, fieldNumber: 1)
    }
    if !self.script.isEmpty {
      try visitor.visitSingularStringField(value: self.script, fieldNumber: 2)
    }
    if !self.region.isEmpty {
      try visitor.visitSingularStringField(value: self.region, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Bilibili_Metadata_Locale_LocaleIds, rhs: Bilibili_Metadata_Locale_LocaleIds) -> Bool {
    if lhs.language != rhs.language {return false}
    if lhs.script != rhs.script {return false}
    if lhs.region != rhs.region {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Bilibili_Metadata_Locale_Locale: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Locale"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "c_locale"),
    2: .standard(proto: "s_locale"),
    3: .standard(proto: "sim_code"),
    4: .same(proto: "timezone"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._cLocale) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._sLocale) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.simCode) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.timezone) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._cLocale {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._sLocale {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if !self.simCode.isEmpty {
      try visitor.visitSingularStringField(value: self.simCode, fieldNumber: 3)
    }
    if !self.timezone.isEmpty {
      try visitor.visitSingularStringField(value: self.timezone, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Bilibili_Metadata_Locale_Locale, rhs: Bilibili_Metadata_Locale_Locale) -> Bool {
    if lhs._cLocale != rhs._cLocale {return false}
    if lhs._sLocale != rhs._sLocale {return false}
    if lhs.simCode != rhs.simCode {return false}
    if lhs.timezone != rhs.timezone {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}