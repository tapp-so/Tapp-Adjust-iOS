import AdjustSdk
import TappCore
import TappNetworking

public typealias Tapp = TappCore
public typealias Affiliate = TappNetworking.Affiliate
public typealias AffiliateURLConfiguration = TappNetworking.AffiliateURLConfiguration
public typealias DeferredLinkDelegate = TappNetworking.DeferredLinkDelegate
public typealias EventActionMapper = TappNetworking.EventActionMapper
public typealias EventAction = TappNetworking.EventAction
public typealias EventConfig = TappNetworking.EventConfig
public typealias TappError = TappNetworking.TappError
public typealias TappConfiguration = TappNetworking.TappConfiguration
public typealias Environment = TappNetworking.Environment

extension Tapp {

    // MARK: - Adjust Specific Features
    enum TappAdjustError: Error {
        case missingService
    }

    @objc
    public static func getAdjustAttribution(completion: @escaping (AdjustAttribution?) -> Void) {
        instance.getAdjustAttribution(completion: completion)
    }

    func getAdjustAttribution(completion: @escaping (AdjustAttribution?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.getAttribution(completion: completion)
    }

    @objc
    public static func adjustGdprForgetMe() {
        instance.adjustGdprForgetMe()
    }

    func adjustGdprForgetMe() {
        guard let adjustService else { return }
        adjustService.gdprForgetMe()
    }

    @objc
    public static func adjustTrackThirdPartySharing(isEnabled: Bool) {
        instance.adjustTrackThirdPartySharing(isEnabled: isEnabled)
    }

    func adjustTrackThirdPartySharing(isEnabled: Bool) {
        guard let adjustService else { return }
        adjustService.trackThirdPartySharing(isEnabled: isEnabled)
    }

    @objc
    public static func adjustTrackAdRevenue(source: String,
                                     revenue: Double,
                                     currency: String) {
        instance.adjustTrackAdRevenue(source: source,
                                    revenue: revenue,
                                    currency: currency)
    }

    func adjustTrackAdRevenue(source: String,
                                     revenue: Double,
                                     currency: String) {
        guard let adjustService else { return }
        adjustService.trackAdRevenue(source: source,
                                                           revenue: revenue,
                                                           currency: currency)
    }

    @objc
    public static func adjustSetPushToken(token: String) {
        instance.adjustSetPushToken(token: token)
    }

    func adjustSetPushToken(token: String) {
        guard let adjustService else { return }
        adjustService.setPushToken(token)
    }

    @objc
    public static func adjustGetAdid(completion: @escaping (String?) -> Void) {
        instance.adjustGetAdid(completion: completion)
    }

    func adjustGetAdid(completion: @escaping (String?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.getAdid(completion: completion)
    }

    @objc
    public static func adjustGetIdfa(completion: @escaping (String?) -> Void) {
        instance.adjustGetIdfa(completion: completion)
    }

    func adjustGetIdfa(completion: @escaping (String?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.getIdfa(completion: completion)
    }

    @objc
    public static func adjustEnable() {
        instance.adjustEnable()
    }

    func adjustEnable() {
        guard let adjustService else { return }
        adjustService.enable()
    }

    @objc public static func adjustDisable() {
        instance.adjustDisable()
    }

    func adjustDisable() {
        guard let adjustService else { return }
        adjustService.disable()
    }

    @objc public static func adjustIsEnabled(completion: @escaping (NSNumber) -> Void) {
        instance.adjustIsEnabled(completion: completion)
    }

    func adjustIsEnabled(completion: @escaping (NSNumber) -> Void) {
        guard let adjustService else {
            completion(NSNumber(value: false))
            return
        }
        adjustService.isEnabled { result in
            if let result {
                completion(NSNumber(value: result))
            } else {
                completion(NSNumber(value: false))
            }
        }
    }

    @objc public static func adjustSwitchToOfflineMode() {
        instance.adjustSwitchToOfflineMode()
    }

    func adjustSwitchToOfflineMode() {
        guard let adjustService else { return }
        adjustService.switchToOfflineMode()
    }

    @objc public static func adjustSwitchBackToOnlineMode() {
        instance.adjustSwitchBackToOnlineMode()
    }

    func adjustSwitchBackToOnlineMode() {
        guard let adjustService else { return }
        adjustService.switchBackToOnlineMode()
    }

    @objc public static func adjustSdkVersion(completion: @escaping (String?) -> Void) {
        instance.adjustSdkVersion(completion: completion)
    }

    func adjustSdkVersion(completion: @escaping (String?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.sdkVersion(completion: completion)
    }

    @objc public static func adjustConvert(universalLink: URL, with scheme: String) -> URL? {
        instance.adjustConvert(universalLink: universalLink, with: scheme)
    }

    func adjustConvert(universalLink: URL, with scheme: String) -> URL? {
        guard let adjustService else { return nil }
        return adjustService.convert(universalLink: universalLink, with: scheme)
    }

    @objc public static func adjustAddGlobalCallbackParameter(_ parameter: String, key: String) {
        instance.adjustAddGlobalCallbackParameter(parameter, key: key)
    }

    func adjustAddGlobalCallbackParameter(_ parameter: String, key: String) {
        guard let adjustService else { return }
        adjustService.addGlobalCallbackParameter(parameter, key: key)
    }

    @objc public static func adjustRemoveGlobalCallbackParameter(for key: String) {
        instance.adjustRemoveGlobalCallbackParameter(for: key)
    }
    
    func adjustRemoveGlobalCallbackParameter(for key: String) {
        guard let adjustService else { return }
        adjustService.removeGlobalCallbackParameter(for: key)
    }

    @objc public static func adjustRemoveGlobalCallbackParameters() {
        instance.adjustRemoveGlobalCallbackParameters()
    }

    func adjustRemoveGlobalCallbackParameters() {
        guard let adjustService else { return }
        adjustService.removeGlobalCallbackParameters()
    }

    @objc public static func adjustAddGlobalPartnerParameter(_ parameter: String, key: String) {
        instance.adjustAddGlobalPartnerParameter(parameter, key: key)
    }

    func adjustAddGlobalPartnerParameter(_ parameter: String, key: String) {
        guard let adjustService else { return }
        adjustService.addGlobalPartnerParameter(parameter, key: key)
    }

    @objc public static func adjustRemoveGlobalPartnerParameter(for key: String) {
        instance.adjustRemoveGlobalPartnerParameter(for: key)
    }

    func adjustRemoveGlobalPartnerParameter(for key: String) {
        guard let adjustService else { return }
        adjustService.removeGlobalPartnerParameter(for: key)
    }

    @objc public static func adjustRemoveGlobalPartnerParameters() {
        instance.adjustRemoveGlobalPartnerParameters()
    }

    func adjustRemoveGlobalPartnerParameters() {
        guard let adjustService else { return }
        adjustService.removeGlobalPartnerParameters()
    }

    @objc public static func adjustTrackMeasurementConsent(_ consent: Bool) {
        instance.adjustTrackMeasurementConsent(consent)
    }

    func adjustTrackMeasurementConsent(_ consent: Bool) {
        guard let adjustService else { return }
        adjustService.trackMeasurementConsent(consent)
    }

    @objc public static func adjustTrackAppStoreSubscription(_ subscription: AdjustAppStoreSubscription) {
        instance.adjustTrackAppStoreSubscription(subscription)
    }

    func adjustTrackAppStoreSubscription(_ subscription: AdjustAppStoreSubscription) {
        guard let adjustService else { return }
        adjustService.trackAppStoreSubscription(subscription)
    }

    @objc public static func adjustRequestAppTrackingAuthorization(completionHandler: @escaping (NSNumber?) -> Void) {
        instance.adjustRequestAppTrackingAuthorization(completionHandler: completionHandler)
    }

    func adjustRequestAppTrackingAuthorization(completionHandler: @escaping (NSNumber?) -> Void) {
        guard let adjustService else {
            completionHandler(nil)
            return
        }
        adjustService.requestAppTrackingAuthorization { value in
            if let value {
                completionHandler(NSNumber(value: value))
            } else {
                completionHandler(nil)
            }
        }
    }

    @objc public static func adjustAppTrackingAuthorizationStatus() -> Int32 {
        instance.adjustAppTrackingAuthorizationStatus()
    }

    func adjustAppTrackingAuthorizationStatus() -> Int32 {
        return adjustService?.appTrackingAuthorizationStatus() ?? 0
    }

    @objc public static func adjustUpdateSkanConversionValue(_ value: Int, coarseValue: String?, lockWindow: NSNumber?, completion: @escaping (Error?) -> Void) {
        instance.adjustUpdateSkanConversionValue(value,
                                               coarseValue: coarseValue,
                                               lockWindow: lockWindow,
                                               completion: completion)
    }
    func adjustUpdateSkanConversionValue(_ value: Int, coarseValue: String?, lockWindow: NSNumber?, completion: @escaping (Error?) -> Void) {
        guard let adjustService else {
            completion(TappAdjustError.missingService)
            return
        }
        adjustService.updateSkanConversionValue(value,
                                                coarseValue: coarseValue,
                                                lockWindow: lockWindow,
                                                completion: completion)
    }

    @objc
    public static func adjustVerifyAppStorePurchase(transactionId: String,
                                             productId: String,
                                                    completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        instance.adjustVerifyAppStorePurchase(transactionId: transactionId,
                                            productId: productId,
                                            completion: completion)
    }

    func adjustVerifyAppStorePurchase(transactionId: String,
                                             productId: String,
                                                    completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.verifyAppStorePurchase(transactionId: transactionId,
                                                      productId: productId,
                                                      completion: completion)
    }

    @objc public static func adjustVerifyAndTrackAppStorePurchase(with event: AdjustEvent, completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        instance.adjustVerifyAndTrackAppStorePurchase(with: event, completion: completion)
    }

    func adjustVerifyAndTrackAppStorePurchase(with event: AdjustEvent, completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.verifyAndTrackAppStorePurchase(with: event, completion: completion)
    }

    fileprivate var adjustService: AdjustServiceProtocol? {
        return AdjustAffiliateService.shared
    }
}
