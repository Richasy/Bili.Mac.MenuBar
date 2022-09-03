//
//  EventBus.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import Foundation

struct Event {
    let id: String
    let eventName: String
    let handler: (Any?) -> Void
}

class EventBus {
    
    init() {
        eventList = [Event]()
    }
    
    var eventList: [Event]
    
    func addEvent(id:String, name: String, handler: @escaping (Any?) -> Void) {
        eventList.append(Event(id: id,eventName: name, handler: handler))
    }
    
    func removeEvent(id:String, name:String) {
        eventList = eventList.filter({ e in
            return e.eventName != name || e.id != id
        })
    }
    
    func fireEvent(name: String, param: Any?) {
        let matchEvents = eventList.filter { e in
            return e.eventName == name
        }
        
        guard !matchEvents.isEmpty else {
            return
        }
        
        for event in matchEvents {
            event.handler(param)
        }
    }
}
