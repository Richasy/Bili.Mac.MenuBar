// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: bilibili/app/card/v1/card.proto
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

/// 卡片信息
struct Bilibili_App_Card_V1_Card {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var item: Bilibili_App_Card_V1_Card.OneOf_Item? = nil

  /// 小封面条目
  var smallCoverV5: Bilibili_App_Card_V1_SmallCoverV5 {
    get {
      if case .smallCoverV5(let v)? = item {return v}
      return Bilibili_App_Card_V1_SmallCoverV5()
    }
    set {item = .smallCoverV5(newValue)}
  }

  var largeCoverV1: Bilibili_App_Card_V1_LargeCoverV1 {
    get {
      if case .largeCoverV1(let v)? = item {return v}
      return Bilibili_App_Card_V1_LargeCoverV1()
    }
    set {item = .largeCoverV1(newValue)}
  }

  var threeItemAllV2: Bilibili_App_Card_V1_ThreeItemAllV2 {
    get {
      if case .threeItemAllV2(let v)? = item {return v}
      return Bilibili_App_Card_V1_ThreeItemAllV2()
    }
    set {item = .threeItemAllV2(newValue)}
  }

  var threeItemV1: Bilibili_App_Card_V1_ThreeItemV1 {
    get {
      if case .threeItemV1(let v)? = item {return v}
      return Bilibili_App_Card_V1_ThreeItemV1()
    }
    set {item = .threeItemV1(newValue)}
  }

  var hotTopic: Bilibili_App_Card_V1_HotTopic {
    get {
      if case .hotTopic(let v)? = item {return v}
      return Bilibili_App_Card_V1_HotTopic()
    }
    set {item = .hotTopic(newValue)}
  }

  var threeItemHV5: Bilibili_App_Card_V1_DynamicHot {
    get {
      if case .threeItemHV5(let v)? = item {return v}
      return Bilibili_App_Card_V1_DynamicHot()
    }
    set {item = .threeItemHV5(newValue)}
  }

  var middleCoverV3: Bilibili_App_Card_V1_MiddleCoverV3 {
    get {
      if case .middleCoverV3(let v)? = item {return v}
      return Bilibili_App_Card_V1_MiddleCoverV3()
    }
    set {item = .middleCoverV3(newValue)}
  }

  var largeCoverV4: Bilibili_App_Card_V1_LargeCoverV4 {
    get {
      if case .largeCoverV4(let v)? = item {return v}
      return Bilibili_App_Card_V1_LargeCoverV4()
    }
    set {item = .largeCoverV4(newValue)}
  }

  /// 热门列表顶部按钮
  var popularTopEntrance: Bilibili_App_Card_V1_PopularTopEntrance {
    get {
      if case .popularTopEntrance(let v)? = item {return v}
      return Bilibili_App_Card_V1_PopularTopEntrance()
    }
    set {item = .popularTopEntrance(newValue)}
  }

  var rcmdOneItem: Bilibili_App_Card_V1_RcmdOneItem {
    get {
      if case .rcmdOneItem(let v)? = item {return v}
      return Bilibili_App_Card_V1_RcmdOneItem()
    }
    set {item = .rcmdOneItem(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Item: Equatable {
    /// 小封面条目
    case smallCoverV5(Bilibili_App_Card_V1_SmallCoverV5)
    case largeCoverV1(Bilibili_App_Card_V1_LargeCoverV1)
    case threeItemAllV2(Bilibili_App_Card_V1_ThreeItemAllV2)
    case threeItemV1(Bilibili_App_Card_V1_ThreeItemV1)
    case hotTopic(Bilibili_App_Card_V1_HotTopic)
    case threeItemHV5(Bilibili_App_Card_V1_DynamicHot)
    case middleCoverV3(Bilibili_App_Card_V1_MiddleCoverV3)
    case largeCoverV4(Bilibili_App_Card_V1_LargeCoverV4)
    /// 热门列表顶部按钮
    case popularTopEntrance(Bilibili_App_Card_V1_PopularTopEntrance)
    case rcmdOneItem(Bilibili_App_Card_V1_RcmdOneItem)

  #if !swift(>=4.1)
    static func ==(lhs: Bilibili_App_Card_V1_Card.OneOf_Item, rhs: Bilibili_App_Card_V1_Card.OneOf_Item) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.smallCoverV5, .smallCoverV5): return {
        guard case .smallCoverV5(let l) = lhs, case .smallCoverV5(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.largeCoverV1, .largeCoverV1): return {
        guard case .largeCoverV1(let l) = lhs, case .largeCoverV1(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.threeItemAllV2, .threeItemAllV2): return {
        guard case .threeItemAllV2(let l) = lhs, case .threeItemAllV2(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.threeItemV1, .threeItemV1): return {
        guard case .threeItemV1(let l) = lhs, case .threeItemV1(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.hotTopic, .hotTopic): return {
        guard case .hotTopic(let l) = lhs, case .hotTopic(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.threeItemHV5, .threeItemHV5): return {
        guard case .threeItemHV5(let l) = lhs, case .threeItemHV5(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.middleCoverV3, .middleCoverV3): return {
        guard case .middleCoverV3(let l) = lhs, case .middleCoverV3(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.largeCoverV4, .largeCoverV4): return {
        guard case .largeCoverV4(let l) = lhs, case .largeCoverV4(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.popularTopEntrance, .popularTopEntrance): return {
        guard case .popularTopEntrance(let l) = lhs, case .popularTopEntrance(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.rcmdOneItem, .rcmdOneItem): return {
        guard case .rcmdOneItem(let l) = lhs, case .rcmdOneItem(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Bilibili_App_Card_V1_Card: @unchecked Sendable {}
extension Bilibili_App_Card_V1_Card.OneOf_Item: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "bilibili.app.card.v1"

extension Bilibili_App_Card_V1_Card: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Card"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "small_cover_v5"),
    2: .standard(proto: "large_cover_v1"),
    3: .standard(proto: "three_item_all_v2"),
    4: .standard(proto: "three_item_v1"),
    5: .standard(proto: "hot_topic"),
    6: .standard(proto: "three_item_h_v5"),
    7: .standard(proto: "middle_cover_v3"),
    8: .standard(proto: "large_cover_v4"),
    9: .standard(proto: "popular_top_entrance"),
    10: .standard(proto: "rcmd_one_item"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: Bilibili_App_Card_V1_SmallCoverV5?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .smallCoverV5(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .smallCoverV5(v)
        }
      }()
      case 2: try {
        var v: Bilibili_App_Card_V1_LargeCoverV1?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .largeCoverV1(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .largeCoverV1(v)
        }
      }()
      case 3: try {
        var v: Bilibili_App_Card_V1_ThreeItemAllV2?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .threeItemAllV2(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .threeItemAllV2(v)
        }
      }()
      case 4: try {
        var v: Bilibili_App_Card_V1_ThreeItemV1?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .threeItemV1(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .threeItemV1(v)
        }
      }()
      case 5: try {
        var v: Bilibili_App_Card_V1_HotTopic?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .hotTopic(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .hotTopic(v)
        }
      }()
      case 6: try {
        var v: Bilibili_App_Card_V1_DynamicHot?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .threeItemHV5(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .threeItemHV5(v)
        }
      }()
      case 7: try {
        var v: Bilibili_App_Card_V1_MiddleCoverV3?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .middleCoverV3(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .middleCoverV3(v)
        }
      }()
      case 8: try {
        var v: Bilibili_App_Card_V1_LargeCoverV4?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .largeCoverV4(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .largeCoverV4(v)
        }
      }()
      case 9: try {
        var v: Bilibili_App_Card_V1_PopularTopEntrance?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .popularTopEntrance(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .popularTopEntrance(v)
        }
      }()
      case 10: try {
        var v: Bilibili_App_Card_V1_RcmdOneItem?
        var hadOneofValue = false
        if let current = self.item {
          hadOneofValue = true
          if case .rcmdOneItem(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.item = .rcmdOneItem(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.item {
    case .smallCoverV5?: try {
      guard case .smallCoverV5(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .largeCoverV1?: try {
      guard case .largeCoverV1(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case .threeItemAllV2?: try {
      guard case .threeItemAllV2(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case .threeItemV1?: try {
      guard case .threeItemV1(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case .hotTopic?: try {
      guard case .hotTopic(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case .threeItemHV5?: try {
      guard case .threeItemHV5(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }()
    case .middleCoverV3?: try {
      guard case .middleCoverV3(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    }()
    case .largeCoverV4?: try {
      guard case .largeCoverV4(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
    }()
    case .popularTopEntrance?: try {
      guard case .popularTopEntrance(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 9)
    }()
    case .rcmdOneItem?: try {
      guard case .rcmdOneItem(let v)? = self.item else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 10)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Bilibili_App_Card_V1_Card, rhs: Bilibili_App_Card_V1_Card) -> Bool {
    if lhs.item != rhs.item {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}