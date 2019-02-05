import Foundation
import EventKit

@objc(CalendarManager)
class CalendarManager: NSObject {

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc(addEvent:location:date:)
  func addEvent(_ name: String, location: String, date: NSNumber) -> Void {
    print("--------- Pretending to create an event " + name + " at " + location + " from " + date.stringValue)
  
    let eventStore = EKEventStore()
    eventStore.requestAccess(to: .event) { (success, error) in
      if error == nil {
        let event = EKEvent.init(eventStore: eventStore)
        
        // 開始時刻を1分後に設定する
        var dataComponents = DateComponents()
        dataComponents.minute = 1
        let eventDate = Calendar.current.date(byAdding: dataComponents, to: Date())

        event.title = name
        event.calendar = eventStore.defaultCalendarForNewEvents
        event.startDate = eventDate
        event.endDate = eventDate
        
        let alarm = EKAlarm.init(absoluteDate: event.startDate)
        event.addAlarm(alarm)

        do {
          try eventStore.save(event, span: .thisEvent)
          print("--------- successfully saved.")
          
        
        } catch let error as NSError{
          print("--------- failed to save event with error : \(error)")
        }
        
      } else {
        print("--------- error = \(String(describing: error?.localizedDescription))")
      }
    }
  }
}
