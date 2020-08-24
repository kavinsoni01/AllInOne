
import Foundation
import UIKit
import Reachability

class AIReachabilityManager: NSObject {
    
    private let reachability = Reachability()
    private var isFirstTimeSetupDone:Bool = false
    private var callCounter:Int = 0
    
    // MARK: - SHARED MANAGER
    static let shared: AIReachabilityManager = AIReachabilityManager()
    
    
    //MARK:- ALL NETWORK CHECK
    func isInternetAvailableForAllNetworks() -> Bool {
        
        if(!self.isFirstTimeSetupDone){
            self.isFirstTimeSetupDone = true
        }
     
        return reachability!.connection != .none ||  reachability!.connection == .wifi || reachability!.connection == .cellular
        
        
    }
    
    
    //MARK:- SETUP
    
    deinit {
        reachability?.stopNotifier()
        //        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
    }
    
    
    
}

