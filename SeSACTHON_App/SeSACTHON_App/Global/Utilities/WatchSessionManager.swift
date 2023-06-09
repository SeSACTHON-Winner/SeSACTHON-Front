import WatchConnectivity
import SwiftUI

class WatchSessionManager: NSObject, WCSessionDelegate,ObservableObject {
    static let sharedManager = WatchSessionManager()
    @Published var watchRunDAO = WatchRunDAO()
    private override init() {
        super.init()
    }
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil

    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }
    #endif

    var validSession: WCSession? {

        // paired - the user has to have their device paired to the watch
        // watchAppInstalled - the user must have your watch app installed

        // Note: if the device is paired, but your watch app is not installed
        // consider prompting the user to install it for a better experience

        #if os(iOS)
            if let session = session, session.isPaired && session.isWatchAppInstalled {
                return session
            }
        #elseif os(watchOS)
            return session
        #endif
        
        return nil
    }
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
}

// MARK: Application Context
// use when your app needs only the latest information
// if the data was not sent, it will be replaced
extension WatchSessionManager {

    // Sender
    func updateApplicationContext(applicationContext: [String : AnyObject]) throws {
        if let session = validSession {
            do {
                try session.updateApplicationContext(applicationContext)
            } catch let error {
                throw error
            }
        }
    }

    // Receiver
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        // handle receiving application context

        DispatchQueue.main.async {
            // make sure to put on the main queue to update UI!
        }
    }
}

// MARK: User Info
// use when your app needs all the data
// FIFO queue
extension WatchSessionManager {

    // Sender
    func transferUserInfo(userInfo: [String : AnyObject]) -> WCSessionUserInfoTransfer? {
        return validSession?.transferUserInfo(userInfo)
    }

    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        // implement this on the sender if you need to confirm that
        // the user info did in fact transfer
    }

    // Receiver
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        // handle receiving user info
        DispatchQueue.main.async {
            // make sure to put on the main queue to update UI!
        }
    }

}

// MARK: Transfer File
extension WatchSessionManager {

    // Sender
    func transferFile(file: NSURL, metadata: [String : AnyObject]) -> WCSessionFileTransfer? {
        return validSession?.transferFile(file as URL, metadata: metadata)
    }

    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        // handle filed transfer completion
    }

    // Receiver
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // handle receiving file
        DispatchQueue.main.async {
            // make sure to put on the main queue to update UI!
        }
    }
}


// MARK: Interactive Messaging
extension WatchSessionManager {

    // Live messaging! App has to be reachable
    private var validReachableSession: WCSession? {
        if let session = validSession , session.isReachable {
            return session
        }
        return nil
    }
    //send WatcchRunDao to paired Device
    func sendWatchRunDao(){
        guard let data = try?JSONEncoder().encode(watchRunDAO) else{return}
        validReachableSession?.sendMessageData(data, replyHandler: nil)
    }
    // send Start WatchRunDAO
    func sendStart(){
        watchRunDAO = watchRunDAO.start()
        sendWatchRunDao()
    }
    // send Stop WatchRunDAO
    func sendStop(){
        watchRunDAO = watchRunDAO.stop()
        sendWatchRunDao()
    }
    // send Pause WatchRunDAO
    func sendPause(){
        watchRunDAO = watchRunDAO.pause()
        sendWatchRunDao()
    }
    
    func sendPlusHelpCount() {
        watchRunDAO = watchRunDAO.plus()
        sendWatchRunDao()
    }

    // Sender
    func sendMessage(message: [String : AnyObject],
                     replyHandler: (([String : Any]) -> Void)? = nil,
                     errorHandler: ((Error) -> Void)? = nil)
    {
        validReachableSession?.sendMessage(message, replyHandler: replyHandler, errorHandler: errorHandler)
    }

    func sendMessageData(data: Data,
                         replyHandler: ((Data) -> Void)? = nil,
                         errorHandler: ((Error) -> Void)? = nil)
    {
        validReachableSession?.sendMessageData(data, replyHandler: replyHandler, errorHandler: errorHandler)
    }

    // Receiver
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        // handle receiving message
    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        // handle receiving message data
        DispatchQueue.main.async {
            guard let message = try? JSONDecoder().decode(WatchRunDAO.self, from: messageData) else {
                return
            }
            let isRestart = self.watchRunDAO.isPause
            print("received message.distance = \(message.distance)")
            if (message.helpNum > self.watchRunDAO.helpNum) {
                NotificationCenter.default.post(name: Notification.Name("helpNum"), object: nil)
            }
            else if message.isStart && !message.isPause && !message.isStop{
                if isRestart{
                    NotificationCenter.default.post(name: Notification.Name("restart"), object: nil)
                }
                else{
                    NotificationCenter.default.post(name: Notification.Name("start"), object: nil)
                }
            }
            else if message.isPause{
                NotificationCenter.default.post(name: Notification.Name("pause"), object: nil)
            }
            else if message.isStop{
                NotificationCenter.default.post(name: Notification.Name("stop"), object: nil)
            }
            self.watchRunDAO = message
            //라딘 추가
        }
    }
}
