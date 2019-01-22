import Foundation

@objc(Counter)
class Counter: RCTEventEmitter {
  
  private var count = 0
  
  // 定数を公開するためにに必要な設定
  // true  - クラスをメインスレッドで初期化する
  // false - クラスをバックグラウンドスレッドで初期化する
  // 基本的にtrueでいいはず
  @objc
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  // swiftの定数を公開するサンプル
  @objc
  override func constantsToExport() -> [AnyHashable : Any]! {
    return ["initialCount": 0]
  }
  
  // EventEmitterでイベントをEmitするにはこれをOverrideするち必要がある
  @objc
  override func supportedEvents() -> [String]! {
    return ["onIncrement", "onDecrement"]
  }
  
  // Method呼び出し&EventEmitterのサンプル
  @objc
  func increment() {
    count += 1
    print("---------- count is \(count)")
    sendEvent(withName: "onIncrement", body: ["count": count])
  }
  
  // Callbackのサンプル
  @objc
  func getCount(_ callback: RCTResponseSenderBlock) {
    callback([count])
  }
  
  // Promiceのサンプル
  @objc
  func decrement(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
    if (count == 0) {
      let error = NSError(domain: "", code: 200, userInfo: nil)
      reject("E_COUNT", "count count cannot be negative.", error)
    } else {
      count -= 1
      print("---------- count is \(count)")
      sendEvent(withName: "onDecrement", body: ["count": count])
      resolve("count was decremented.")
    }
  }
}
