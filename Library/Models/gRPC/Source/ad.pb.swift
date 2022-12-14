// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: bilibili/app/card/v1/ad.proto
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

struct Bilibili_App_Card_V1_AdInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var creativeID: Int64 {
    get {return _storage._creativeID}
    set {_uniqueStorage()._creativeID = newValue}
  }

  var creativeType: Int32 {
    get {return _storage._creativeType}
    set {_uniqueStorage()._creativeType = newValue}
  }

  var cardType: Int32 {
    get {return _storage._cardType}
    set {_uniqueStorage()._cardType = newValue}
  }

  var creativeContent: Bilibili_App_Card_V1_CreativeContent {
    get {return _storage._creativeContent ?? Bilibili_App_Card_V1_CreativeContent()}
    set {_uniqueStorage()._creativeContent = newValue}
  }
  /// Returns true if `creativeContent` has been explicitly set.
  var hasCreativeContent: Bool {return _storage._creativeContent != nil}
  /// Clears the value of `creativeContent`. Subsequent reads from it will return its default value.
  mutating func clearCreativeContent() {_uniqueStorage()._creativeContent = nil}

  var adCb: String {
    get {return _storage._adCb}
    set {_uniqueStorage()._adCb = newValue}
  }

  var resource: Int64 {
    get {return _storage._resource}
    set {_uniqueStorage()._resource = newValue}
  }

  var source: Int32 {
    get {return _storage._source}
    set {_uniqueStorage()._source = newValue}
  }

  var requestID: String {
    get {return _storage._requestID}
    set {_uniqueStorage()._requestID = newValue}
  }

  var isAd: Bool {
    get {return _storage._isAd}
    set {_uniqueStorage()._isAd = newValue}
  }

  var cmMark: Int64 {
    get {return _storage._cmMark}
    set {_uniqueStorage()._cmMark = newValue}
  }

  var index: Int32 {
    get {return _storage._index}
    set {_uniqueStorage()._index = newValue}
  }

  var isAdLoc: Bool {
    get {return _storage._isAdLoc}
    set {_uniqueStorage()._isAdLoc = newValue}
  }

  var cardIndex: Int32 {
    get {return _storage._cardIndex}
    set {_uniqueStorage()._cardIndex = newValue}
  }

  var clientIp: String {
    get {return _storage._clientIp}
    set {_uniqueStorage()._clientIp = newValue}
  }

  var extra: Data {
    get {return _storage._extra}
    set {_uniqueStorage()._extra = newValue}
  }

  var creativeStyle: Int32 {
    get {return _storage._creativeStyle}
    set {_uniqueStorage()._creativeStyle = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Bilibili_App_Card_V1_CreativeContent {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var title: String = String()

  var description_p: String = String()

  var videoID: Int64 = 0

  var username: String = String()

  var imageURL: String = String()

  var imageMd5: String = String()

  var logURL: String = String()

  var logMd5: String = String()

  var url: String = String()

  var clickURL: String = String()

  var showURL: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Bilibili_App_Card_V1_AdInfo: @unchecked Sendable {}
extension Bilibili_App_Card_V1_CreativeContent: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "bilibili.app.card.v1"

extension Bilibili_App_Card_V1_AdInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AdInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "creative_id"),
    2: .standard(proto: "creative_type"),
    3: .standard(proto: "card_type"),
    4: .standard(proto: "creative_content"),
    5: .standard(proto: "ad_cb"),
    6: .same(proto: "resource"),
    7: .same(proto: "source"),
    8: .standard(proto: "request_id"),
    9: .standard(proto: "is_ad"),
    10: .standard(proto: "cm_mark"),
    11: .same(proto: "index"),
    12: .standard(proto: "is_ad_loc"),
    13: .standard(proto: "card_index"),
    14: .standard(proto: "client_ip"),
    15: .same(proto: "extra"),
    16: .standard(proto: "creative_style"),
  ]

  fileprivate class _StorageClass {
    var _creativeID: Int64 = 0
    var _creativeType: Int32 = 0
    var _cardType: Int32 = 0
    var _creativeContent: Bilibili_App_Card_V1_CreativeContent? = nil
    var _adCb: String = String()
    var _resource: Int64 = 0
    var _source: Int32 = 0
    var _requestID: String = String()
    var _isAd: Bool = false
    var _cmMark: Int64 = 0
    var _index: Int32 = 0
    var _isAdLoc: Bool = false
    var _cardIndex: Int32 = 0
    var _clientIp: String = String()
    var _extra: Data = Data()
    var _creativeStyle: Int32 = 0

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _creativeID = source._creativeID
      _creativeType = source._creativeType
      _cardType = source._cardType
      _creativeContent = source._creativeContent
      _adCb = source._adCb
      _resource = source._resource
      _source = source._source
      _requestID = source._requestID
      _isAd = source._isAd
      _cmMark = source._cmMark
      _index = source._index
      _isAdLoc = source._isAdLoc
      _cardIndex = source._cardIndex
      _clientIp = source._clientIp
      _extra = source._extra
      _creativeStyle = source._creativeStyle
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularInt64Field(value: &_storage._creativeID) }()
        case 2: try { try decoder.decodeSingularInt32Field(value: &_storage._creativeType) }()
        case 3: try { try decoder.decodeSingularInt32Field(value: &_storage._cardType) }()
        case 4: try { try decoder.decodeSingularMessageField(value: &_storage._creativeContent) }()
        case 5: try { try decoder.decodeSingularStringField(value: &_storage._adCb) }()
        case 6: try { try decoder.decodeSingularInt64Field(value: &_storage._resource) }()
        case 7: try { try decoder.decodeSingularInt32Field(value: &_storage._source) }()
        case 8: try { try decoder.decodeSingularStringField(value: &_storage._requestID) }()
        case 9: try { try decoder.decodeSingularBoolField(value: &_storage._isAd) }()
        case 10: try { try decoder.decodeSingularInt64Field(value: &_storage._cmMark) }()
        case 11: try { try decoder.decodeSingularInt32Field(value: &_storage._index) }()
        case 12: try { try decoder.decodeSingularBoolField(value: &_storage._isAdLoc) }()
        case 13: try { try decoder.decodeSingularInt32Field(value: &_storage._cardIndex) }()
        case 14: try { try decoder.decodeSingularStringField(value: &_storage._clientIp) }()
        case 15: try { try decoder.decodeSingularBytesField(value: &_storage._extra) }()
        case 16: try { try decoder.decodeSingularInt32Field(value: &_storage._creativeStyle) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      if _storage._creativeID != 0 {
        try visitor.visitSingularInt64Field(value: _storage._creativeID, fieldNumber: 1)
      }
      if _storage._creativeType != 0 {
        try visitor.visitSingularInt32Field(value: _storage._creativeType, fieldNumber: 2)
      }
      if _storage._cardType != 0 {
        try visitor.visitSingularInt32Field(value: _storage._cardType, fieldNumber: 3)
      }
      try { if let v = _storage._creativeContent {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      } }()
      if !_storage._adCb.isEmpty {
        try visitor.visitSingularStringField(value: _storage._adCb, fieldNumber: 5)
      }
      if _storage._resource != 0 {
        try visitor.visitSingularInt64Field(value: _storage._resource, fieldNumber: 6)
      }
      if _storage._source != 0 {
        try visitor.visitSingularInt32Field(value: _storage._source, fieldNumber: 7)
      }
      if !_storage._requestID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._requestID, fieldNumber: 8)
      }
      if _storage._isAd != false {
        try visitor.visitSingularBoolField(value: _storage._isAd, fieldNumber: 9)
      }
      if _storage._cmMark != 0 {
        try visitor.visitSingularInt64Field(value: _storage._cmMark, fieldNumber: 10)
      }
      if _storage._index != 0 {
        try visitor.visitSingularInt32Field(value: _storage._index, fieldNumber: 11)
      }
      if _storage._isAdLoc != false {
        try visitor.visitSingularBoolField(value: _storage._isAdLoc, fieldNumber: 12)
      }
      if _storage._cardIndex != 0 {
        try visitor.visitSingularInt32Field(value: _storage._cardIndex, fieldNumber: 13)
      }
      if !_storage._clientIp.isEmpty {
        try visitor.visitSingularStringField(value: _storage._clientIp, fieldNumber: 14)
      }
      if !_storage._extra.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._extra, fieldNumber: 15)
      }
      if _storage._creativeStyle != 0 {
        try visitor.visitSingularInt32Field(value: _storage._creativeStyle, fieldNumber: 16)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Bilibili_App_Card_V1_AdInfo, rhs: Bilibili_App_Card_V1_AdInfo) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._creativeID != rhs_storage._creativeID {return false}
        if _storage._creativeType != rhs_storage._creativeType {return false}
        if _storage._cardType != rhs_storage._cardType {return false}
        if _storage._creativeContent != rhs_storage._creativeContent {return false}
        if _storage._adCb != rhs_storage._adCb {return false}
        if _storage._resource != rhs_storage._resource {return false}
        if _storage._source != rhs_storage._source {return false}
        if _storage._requestID != rhs_storage._requestID {return false}
        if _storage._isAd != rhs_storage._isAd {return false}
        if _storage._cmMark != rhs_storage._cmMark {return false}
        if _storage._index != rhs_storage._index {return false}
        if _storage._isAdLoc != rhs_storage._isAdLoc {return false}
        if _storage._cardIndex != rhs_storage._cardIndex {return false}
        if _storage._clientIp != rhs_storage._clientIp {return false}
        if _storage._extra != rhs_storage._extra {return false}
        if _storage._creativeStyle != rhs_storage._creativeStyle {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Bilibili_App_Card_V1_CreativeContent: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CreativeContent"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "title"),
    2: .same(proto: "description"),
    3: .standard(proto: "video_id"),
    4: .same(proto: "username"),
    5: .standard(proto: "image_url"),
    6: .standard(proto: "image_md5"),
    7: .standard(proto: "log_url"),
    8: .standard(proto: "log_md5"),
    9: .same(proto: "url"),
    10: .standard(proto: "click_url"),
    11: .standard(proto: "show_url"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.title) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.description_p) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.videoID) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.username) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self.imageURL) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self.imageMd5) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self.logURL) }()
      case 8: try { try decoder.decodeSingularStringField(value: &self.logMd5) }()
      case 9: try { try decoder.decodeSingularStringField(value: &self.url) }()
      case 10: try { try decoder.decodeSingularStringField(value: &self.clickURL) }()
      case 11: try { try decoder.decodeSingularStringField(value: &self.showURL) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.title.isEmpty {
      try visitor.visitSingularStringField(value: self.title, fieldNumber: 1)
    }
    if !self.description_p.isEmpty {
      try visitor.visitSingularStringField(value: self.description_p, fieldNumber: 2)
    }
    if self.videoID != 0 {
      try visitor.visitSingularInt64Field(value: self.videoID, fieldNumber: 3)
    }
    if !self.username.isEmpty {
      try visitor.visitSingularStringField(value: self.username, fieldNumber: 4)
    }
    if !self.imageURL.isEmpty {
      try visitor.visitSingularStringField(value: self.imageURL, fieldNumber: 5)
    }
    if !self.imageMd5.isEmpty {
      try visitor.visitSingularStringField(value: self.imageMd5, fieldNumber: 6)
    }
    if !self.logURL.isEmpty {
      try visitor.visitSingularStringField(value: self.logURL, fieldNumber: 7)
    }
    if !self.logMd5.isEmpty {
      try visitor.visitSingularStringField(value: self.logMd5, fieldNumber: 8)
    }
    if !self.url.isEmpty {
      try visitor.visitSingularStringField(value: self.url, fieldNumber: 9)
    }
    if !self.clickURL.isEmpty {
      try visitor.visitSingularStringField(value: self.clickURL, fieldNumber: 10)
    }
    if !self.showURL.isEmpty {
      try visitor.visitSingularStringField(value: self.showURL, fieldNumber: 11)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Bilibili_App_Card_V1_CreativeContent, rhs: Bilibili_App_Card_V1_CreativeContent) -> Bool {
    if lhs.title != rhs.title {return false}
    if lhs.description_p != rhs.description_p {return false}
    if lhs.videoID != rhs.videoID {return false}
    if lhs.username != rhs.username {return false}
    if lhs.imageURL != rhs.imageURL {return false}
    if lhs.imageMd5 != rhs.imageMd5 {return false}
    if lhs.logURL != rhs.logURL {return false}
    if lhs.logMd5 != rhs.logMd5 {return false}
    if lhs.url != rhs.url {return false}
    if lhs.clickURL != rhs.clickURL {return false}
    if lhs.showURL != rhs.showURL {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
