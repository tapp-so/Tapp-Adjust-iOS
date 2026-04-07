import Foundation
import AdjustSdk
import TappNetworking
import Tapp

protocol AdjustInterfaceProtocol: AnyObject {
    var deferredLinkDelegate: DeferredLinkDelegate? { get }
    func set(deferredLinkDelegate: DeferredLinkDelegate)
    
    func initialize(appToken: String, environment: Environment)
    func processDeepLink(url: URL, completion: ResolvedURLCompletion?)
    func trackEvent(eventID: String) -> Bool 

    func getAttribution(completion: @escaping (AdjustAttribution?) -> Void) 
    func gdprForgetMe() 
    func trackThirdPartySharing(isEnabled: Bool) 
    func trackAdRevenue(source: String,
                        revenue: Double,
                        currency: String)

    func setPushToken(_ token: String) 
    func getAdid(completion: @escaping (String?) -> Void) 
    func getIdfa(completion: @escaping (String?) -> Void) 
    func getIdfv(completion: @escaping (String?) -> Void) 

    func enable() 
    func disable() 
    func isEnabled(completion: @escaping (Bool?) -> Void) 
    func switchToOfflineMode() 
    func switchBackToOnlineMode() 
    func sdkVersion(completion: @escaping (String?) -> Void) 
    func convert(universalLink: URL, with scheme: String) -> URL? 
    func addGlobalCallbackParameter(_ parameter: String, key: String) 
    func removeGlobalCallbackParameter(for key: String) 
    func removeGlobalCallbackParameters() 
    func addGlobalPartnerParameter(_ parameter: String, key: String) 
    func removeGlobalPartnerParameter(for key: String) 
    func removeGlobalPartnerParameters() 
    func trackMeasurementConsent(_ consent: Bool) 
    func trackAppStoreSubscription(_ subscription: AdjustAppStoreSubscription)
    func requestAppTrackingAuthorization(completionHandler: @escaping (UInt?) -> Void) 
    func appTrackingAuthorizationStatus() -> Int32 
    func updateSkanConversionValue(_ value: Int, coarseValue: String?, lockWindow: NSNumber?, completion: @escaping (Error?) -> Void) 

    func verifyAppStorePurchase(transactionId: String,
                                productId: String,
                                completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) 
    func verifyAndTrackAppStorePurchase(with event: AdjustEvent, completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) 

}

final class AdjustInterface: NSObject, AdjustInterfaceProtocol {
    weak var deferredLinkDelegate: DeferredLinkDelegate?
    private var environment: Environment = .sandbox

    func initialize(appToken: String,
                    environment: Environment) {
        self.environment = environment
        let adjustConfig = ADJConfig(appToken: appToken,
                                     environment: environment.adjustEnvironment)

        adjustConfig?.logLevel = .verbose
        adjustConfig?.delegate = self

        Adjust.initSdk(adjustConfig)
    }

    func set(deferredLinkDelegate: DeferredLinkDelegate) {
        self.deferredLinkDelegate = deferredLinkDelegate
    }

    func processDeepLink(url: URL, completion: ResolvedURLCompletion?) {

        let context = "Process deep link (Adjust)"
        TappLog.logInfo(message: "Will process deep link (\(url.absoluteString))",
                        environment: environment,
                        context: context)

        ADJLinkResolution.resolveLink(with: url, resolveUrlSuffixArray: ["adj.st"]) { [weak self] resolvedURL in
            guard let resolvedURL else {
                let error = ResolvedURLError.cannotResolveURL
                if let self {
                    TappLog.logError(error, environment: self.environment, context: context)
                }

                completion?(Result.failure(error))

                return
            }
            guard let deepLink = ADJDeeplink(deeplink: resolvedURL) else {
                let error = ResolvedURLError.cannotResolveDeepLink
                if let self {
                    TappLog.logError(error, environment: self.environment, context: context)
                }

                completion?(Result.failure(error))
                return
            }

            Adjust.processDeeplink(deepLink)
            if let self {
                TappLog.logInfo(message: "Did process deep link (\(resolvedURL.absoluteString))",
                                environment: environment,
                                context: context)
            }

            completion?(Result.success(resolvedURL))
        }
    }

    func trackEvent(eventID: String) -> Bool {
        let context = "Track event (Adjust)"
        TappLog.logInfo(message: "Will track event (\(eventID))",
                        environment: environment,
                        context: context)
        if let event = ADJEvent(eventToken: eventID) {
            Adjust.trackEvent(event)
            TappLog.logInfo(message: "Did track event (\(eventID))",
                            environment: environment,
                            context: context)
            return true
        }
        return false
    }

    func getAttribution(completion: @escaping (AdjustAttribution?) -> Void)
    {
        let context = "Get attribution (Adjust)"
        TappLog.logInfo(message: "Will retrieve attribution",
                        environment: environment,
                        context: context)
        Adjust.attribution { [weak self] attribution in
            if let self, let attribution {
                TappLog.logInfo(message: "Did retrieve attribution (\(attribution)",
                                environment: self.environment,
                                context: context)
            }
            completion(AdjustAttribution(adjAttribution: attribution))
        }
    }

    func gdprForgetMe() {
        TappLog.logInfo(message: "GDPR Forget me",
                        environment: environment,
                        context: "GDPR Forget me (Adjust)")

        Adjust.gdprForgetMe()
    }

    func trackThirdPartySharing(isEnabled: Bool) {
        let context = "Track third party sharing (Adjust)"
        TappLog.logInfo(message: "Will track third party sharing (\(isEnabled))",
                        environment: environment,
                        context: context)

        guard let thirdPartySharing = ADJThirdPartySharing(isEnabled: NSNumber(value: isEnabled)) else {
            TappLog.logInfo(message: "Will not track third party sharing (\(isEnabled)) - ADJThirdPartySharing Initialization",
                            environment: environment,
                            context: context)
            return
        }
        TappLog.logInfo(message: "Did track third party sharing (\(isEnabled))",
                        environment: environment,
                        context: context)
        Adjust.trackThirdPartySharing(thirdPartySharing)
    }

    func trackAdRevenue(source: String,
                        revenue: Double,
                        currency: String) {
        let context = "Track ad revenue (Adjust)"
        TappLog.logInfo(message: "Will track ad revenue with source \(source), revenue: \(revenue), currency: \(currency)",
                        environment: environment,
                        context: context)
        if let adRevenue = ADJAdRevenue(source: source) {
            adRevenue.setRevenue(revenue, currency: currency)
            Adjust.trackAdRevenue(adRevenue)
            TappLog.logInfo(message: "Did track ad revenue with source \(source), revenue: \(revenue), currency: \(currency)",
                            environment: environment,
                            context: context)
        } else {
            TappLog.logInfo(message: "Did not track ad revenue with source \(source), revenue: \(revenue), currency: \(currency) - Initialization failed",
                            environment: environment,
                            context: context)
        }
    }

    func setPushToken(_ token: String) {
        TappLog.logInfo(message: "Will set push token",
                        environment: environment,
                        context: "Push token (Adjust)")
        Adjust.setPushTokenAs(token)
    }

    func getAdid(completion: @escaping (String?) -> Void) {
        let context = "Get adid (Adjust)"
        TappLog.logInfo(message: "Will get adid", environment: environment, context: context)
        Adjust.adid { [weak self] adid in
            if let self {
                if let adid {
                    TappLog.logInfo(message: "Did get adid: \(adid)", environment: self.environment, context: context)
                } else {
                    TappLog.logInfo(message: "Did not get adid", environment: self.environment, context: context)
                }
            }
            completion(adid)
        }
    }

    func getIdfa(completion: @escaping (String?) -> Void) {
        let context = "Get idfa (Adjust)"
        TappLog.logInfo(message: "Will get idfa", environment: environment, context: context)
        Adjust.idfa { [weak self] idfa in
            if let self {
                if let idfa {
                    TappLog.logInfo(message: "Did get idfa: \(idfa)", environment: self.environment, context: context)
                } else {
                    TappLog.logInfo(message: "Did not get idfa", environment: self.environment, context: context)
                }
            }
            completion(idfa)
        }
    }

    func getIdfv(completion: @escaping (String?) -> Void) {
        let context = "Get idfv (Adjust)"
        TappLog.logInfo(message: "Will get idfv", environment: environment, context: context)
        Adjust.idfv { [weak self] idfv in
            if let self {
                if let idfv {
                    TappLog.logInfo(message: "Did get idfv: \(idfv)", environment: self.environment, context: context)
                } else {
                    TappLog.logInfo(message: "Did not get idfv", environment: self.environment, context: context)
                }
            }
            completion(idfv)
        }
    }

    func enable() {
        TappLog.logInfo(message: "Adjust enabled", environment: self.environment, context: "Adjust")
        Adjust.enable()
    }

    func disable() {
        TappLog.logInfo(message: "Adjust disabled", environment: self.environment, context: "Adjust")
        Adjust.disable()
    }

    func isEnabled(completion: @escaping (Bool?) -> Void) {
        let context = "Adjust enabled check"
        TappLog.logInfo(message: "Will fetch Adjust enabled status",
                        environment: environment,
                        context: context)
        Adjust.isEnabled { [weak self] value in
            if let self {
                TappLog.logInfo(message: "Did fetch Adjust enabled status with value: \(value)",
                                environment: environment,
                                context: context)
            }
            completion(value)
        }
    }

    func switchToOfflineMode() {
        TappLog.logInfo(message: "Adjust switch to offline mode", environment: self.environment, context: "Adjust")
        Adjust.switchToOfflineMode()
    }

    func switchBackToOnlineMode() {
        TappLog.logInfo(message: "Adjust switch to online mode", environment: self.environment, context: "Adjust")
        Adjust.switchBackToOnlineMode()
    }

    func sdkVersion(completion: @escaping (String?) -> Void) {
        let context = "Adjust sdk version"
        TappLog.logInfo(message: "Will fetch Adjust sdk version",
                        environment: environment,
                        context: context)
        Adjust.sdkVersion { [weak self] value in
            if let self {
                if let value {
                    TappLog.logInfo(message: "Did fetch Adjust sdk version \(value)",
                                    environment: environment,
                                    context: context)
                } else {
                    TappLog.logInfo(message: "Did not fetch Adjust sdk version",
                                    environment: environment,
                                    context: context)
                }
            }
            completion(value)
        }
    }

    func convert(universalLink: URL, with scheme: String) -> URL? {
        let context = "Adjust convert universal link"

        let value = Adjust.convertUniversalLink(universalLink, withScheme: scheme)

        if let value {
            TappLog.logInfo(message: "Did convert universal link: \(universalLink) to url: \(value)",
                            environment: environment,
                            context: context)
        } else {
            TappLog.logInfo(message: "Did not convert universal link: \(universalLink)",
                            environment: environment,
                            context: context)
        }

        return value
    }

    func addGlobalCallbackParameter(_ parameter: String, key: String) {
        TappLog.logInfo(message: "Will add global callback parameter (\(parameter)) for key: (\(key))",
                        environment: environment,
                        context: "Adjust")
        Adjust.addGlobalCallbackParameter(parameter, forKey: key)
    }

    func removeGlobalCallbackParameter(for key: String) {
        TappLog.logInfo(message: "Will remove global callback parameter for key (\(key))",
                        environment: environment,
                        context: "Adjust")
        Adjust.removeGlobalCallbackParameter(forKey: key)
    }

    func removeGlobalCallbackParameters() {
        TappLog.logInfo(message: "Will remove all global callback parameters",
                        environment: environment,
                        context: "Adjust")
        Adjust.removeGlobalCallbackParameters()
    }

    func addGlobalPartnerParameter(_ parameter: String, key: String) {
        TappLog.logInfo(message: "Will add global partner parameter (\(parameter)) for key: (\(key))",
                        environment: environment,
                        context: "Adjust")
        Adjust.addGlobalPartnerParameter(parameter, forKey: key)
    }

    func removeGlobalPartnerParameter(for key: String) {
        TappLog.logInfo(message: "Will remove global partner parameter for key (\(key))",
                        environment: environment,
                        context: "Adjust")
        Adjust.removeGlobalPartnerParameter(forKey: key)
    }

    func removeGlobalPartnerParameters() {
        TappLog.logInfo(message: "Will remove all global partner parameters",
                        environment: environment,
                        context: "Adjust")
        Adjust.removeGlobalPartnerParameters()
    }

    func trackMeasurementConsent(_ consent: Bool)  {
        TappLog.logInfo(message: "Will track measurement consent with value: \(consent)",
                        environment: environment,
                        context: "Adjust")
        Adjust.trackMeasurementConsent(consent)
    }

    func trackAppStoreSubscription(_ subscription: AdjustAppStoreSubscription) {
        if let object = subscription.adjObject {
            TappLog.logInfo(message: "Will track app store subscription with transactionID \(subscription.transactionId)",
                            environment: environment,
                            context: "Adjust")
            Adjust.trackAppStoreSubscription(object)
        } else {
            TappLog.logInfo(message: "Did not track app store subscription with transactionID \(subscription.transactionId) - Initialization failed",
                            environment: environment,
                            context: "Adjust")
        }
    }

    func requestAppTrackingAuthorization(completionHandler: @escaping (UInt?) -> Void) {
        let context = "Adjust"
        TappLog.logInfo(message: "Will request app tracking authorization",
                        environment: environment,
                        context: context)
        Adjust.requestAppTrackingAuthorization { [weak self] value in
            if let self {
                TappLog.logInfo(message: "Did receive app tracking authorization with value: \(value)",
                                environment: self.environment,
                                context: context)
            }
            completionHandler(value)
        }
    }

    func appTrackingAuthorizationStatus() -> Int32 {
        let value = Adjust.appTrackingAuthorizationStatus()

        TappLog.logInfo(message: "Did fetch app tracking authorization with value: \(value)",
                        environment: environment,
                        context: "Adjust")
        return value
    }

    func updateSkanConversionValue(_ value: Int, coarseValue: String?, lockWindow: NSNumber?, completion: @escaping (Error?) -> Void) {
        let context = "Adjust Skan conversion value update"
        TappLog.logInfo(message: "Will attempt to update Skan conversion with value: \(value)",
                        environment: environment,
                        context: context)
        Adjust.updateSkanConversionValue(value, coarseValue: coarseValue, lockWindow: lockWindow) { [weak self] error in

            if let self {
                if let error {
                    TappLog.logError(error,
                                     environment: self.environment,
                                     context: context)
                } else {
                    TappLog.logInfo(message: "Did update Skan conversion with value: \(value)",
                                    environment: self.environment,
                                    context: context)
                }
            }
            completion(error)
        }
    }

    func verifyAppStorePurchase(transactionId: String,
                                productId: String,
                                completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        let context = "Adjust verify app store purchase"
        TappLog.logInfo(message: "Will attempt to verify app store purchase with transactionId: \(transactionId)",
                        environment: self.environment,
                        context: context)
        if let purchase = ADJAppStorePurchase(transactionId: transactionId, productId: productId) {
            Adjust.verifyAppStorePurchase(purchase) { [weak self] result in
                if let self {
                    TappLog.logInfo(message: "Did verify app store purchase with result: \(result)",
                                    environment: self.environment,
                                    context: context)
                }
                completion(AdjustPurchaseVerificationResult(adjResult: result))
            }
        } else {
            TappLog.logInfo(message: "Did not verify app store purchase with transactionId: \(transactionId) - Initialization failed",
                            environment: self.environment,
                            context: context)
            completion(nil)
        }
    }

    func verifyAndTrackAppStorePurchase(with event: AdjustEvent, completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        let context = "Adjust verify and track app store purchase"

        guard let object = event.adjObject else {
            TappLog.logInfo(message: "Did not verify and track app store purchase with eventToken: \(event.eventToken) - Initialization failed",
                            environment: self.environment,
                            context: context)
            completion(nil)
            return
        }

        TappLog.logInfo(message: "Will attempt to verify and track app store purchase with eventToken: \(event.eventToken)",
                        environment: self.environment,
                        context: context)
        Adjust.verifyAndTrackAppStorePurchase(object) { [weak self] result in
            if let self {
                TappLog.logInfo(message: "Did verify and track app store purchase with eventToken: \(event.eventToken) with result: \(result)",
                                environment: self.environment,
                                context: context)
            }
            let verificationResult = AdjustPurchaseVerificationResult(adjResult: result)
            completion(verificationResult)
        }
    }
}

private extension Environment {
    var adjustEnvironment: String {
        switch self {
        case .sandbox:
            return ADJEnvironmentSandbox
        case .production:
            return ADJEnvironmentProduction
        }
    }
}

extension AdjustInterface: AdjustDelegate {
    func adjustDeferredDeeplinkReceived(_ deeplink: URL?) -> Bool {
        if let deeplink {
            deferredLinkDelegate?.didReceiveDeferredLink(deeplink)
        }

        return true
    }
}
