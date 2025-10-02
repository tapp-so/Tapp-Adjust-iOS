import AdjustSdk
import Tapp
import TappNetworking

public typealias Affiliate = TappNetworking.Affiliate
public typealias AffiliateURLConfiguration = TappNetworking.AffiliateURLConfiguration
public typealias DeferredLinkDelegate = TappNetworking.DeferredLinkDelegate
public typealias EventActionMapper = TappNetworking.EventActionMapper
public typealias EventAction = TappNetworking.EventAction
public typealias EventConfig = TappNetworking.EventConfig
public typealias TappError = TappNetworking.TappError
public typealias TappConfiguration = TappNetworking.TappConfiguration
public typealias Environment = TappNetworking.Environment

@objc
public extension Tapp {
    // MARK: - Adjust Specific Features
    enum TappAdjustError: Error {
        case missingService
    }

    @objc
    static func getAdjustAttribution(completion: @escaping (AdjustAttribution?) -> Void) {
        instance.getAdjustAttribution(completion: completion)
    }

    private func getAdjustAttribution(completion: @escaping (AdjustAttribution?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.getAttribution(completion: completion)
    }

    @objc
    static func adjustGdprForgetMe() {
        instance.adjustGdprForgetMe()
    }

    private func adjustGdprForgetMe() {
        guard let adjustService else { return }
        adjustService.gdprForgetMe()
    }

    @objc
    static func adjustTrackThirdPartySharing(isEnabled: Bool) {
        instance.adjustTrackThirdPartySharing(isEnabled: isEnabled)
    }

    private func adjustTrackThirdPartySharing(isEnabled: Bool) {
        guard let adjustService else { return }
        adjustService.trackThirdPartySharing(isEnabled: isEnabled)
    }

    @objc
    static func adjustTrackAdRevenue(source: String,
                                     revenue: Double,
                                     currency: String) {
        instance.adjustTrackAdRevenue(source: source,
                                    revenue: revenue,
                                    currency: currency)
    }

    private func adjustTrackAdRevenue(source: String,
                                     revenue: Double,
                                     currency: String) {
        guard let adjustService else { return }
        adjustService.trackAdRevenue(source: source,
                                                           revenue: revenue,
                                                           currency: currency)
    }

    @objc
    static func adjustSetPushToken(token: String) {
        instance.adjustSetPushToken(token: token)
    }

    private func adjustSetPushToken(token: String) {
        guard let adjustService else { return }
        adjustService.setPushToken(token)
    }

    @objc
    static func adjustGetAdid(completion: @escaping (String?) -> Void) {
        instance.adjustGetAdid(completion: completion)
    }

    private func adjustGetAdid(completion: @escaping (String?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.getAdid(completion: completion)
    }

    @objc
    static func adjustGetIdfa(completion: @escaping (String?) -> Void) {
        instance.adjustGetIdfa(completion: completion)
    }

    private func adjustGetIdfa(completion: @escaping (String?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.getIdfa(completion: completion)
    }

    @objc
    static func adjustEnable() {
        instance.adjustEnable()
    }

    private func adjustEnable() {
        guard let adjustService else { return }
        adjustService.enable()
    }

    @objc
    static func adjustDisable() {
        instance.adjustDisable()
    }

    private func adjustDisable() {
        guard let adjustService else { return }
        adjustService.disable()
    }

    @objc
    static func adjustIsEnabled(completion: @escaping (NSNumber) -> Void) {
        instance.adjustIsEnabled(completion: completion)
    }

    private func adjustIsEnabled(completion: @escaping (NSNumber) -> Void) {
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

    @objc
    static func adjustSwitchToOfflineMode() {
        instance.adjustSwitchToOfflineMode()
    }

    private func adjustSwitchToOfflineMode() {
        guard let adjustService else { return }
        adjustService.switchToOfflineMode()
    }

    @objc
    static func adjustSwitchBackToOnlineMode() {
        instance.adjustSwitchBackToOnlineMode()
    }

    private func adjustSwitchBackToOnlineMode() {
        guard let adjustService else { return }
        adjustService.switchBackToOnlineMode()
    }

    @objc
    static func adjustSdkVersion(completion: @escaping (String?) -> Void) {
        instance.adjustSdkVersion(completion: completion)
    }

    private func adjustSdkVersion(completion: @escaping (String?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.sdkVersion(completion: completion)
    }

    @objc
    static func adjustConvert(universalLink: URL, with scheme: String) -> URL? {
        instance.adjustConvert(universalLink: universalLink, with: scheme)
    }

    private func adjustConvert(universalLink: URL, with scheme: String) -> URL? {
        guard let adjustService else { return nil }
        return adjustService.convert(universalLink: universalLink, with: scheme)
    }

    @objc
    static func adjustAddGlobalCallbackParameter(_ parameter: String, key: String) {
        instance.adjustAddGlobalCallbackParameter(parameter, key: key)
    }

    private func adjustAddGlobalCallbackParameter(_ parameter: String, key: String) {
        guard let adjustService else { return }
        adjustService.addGlobalCallbackParameter(parameter, key: key)
    }

    @objc
    static func adjustRemoveGlobalCallbackParameter(for key: String) {
        instance.adjustRemoveGlobalCallbackParameter(for: key)
    }
    
    private func adjustRemoveGlobalCallbackParameter(for key: String) {
        guard let adjustService else { return }
        adjustService.removeGlobalCallbackParameter(for: key)
    }

    @objc
    static func adjustRemoveGlobalCallbackParameters() {
        instance.adjustRemoveGlobalCallbackParameters()
    }

    private func adjustRemoveGlobalCallbackParameters() {
        guard let adjustService else { return }
        adjustService.removeGlobalCallbackParameters()
    }

    @objc
    static func adjustAddGlobalPartnerParameter(_ parameter: String, key: String) {
        instance.adjustAddGlobalPartnerParameter(parameter, key: key)
    }

    private func adjustAddGlobalPartnerParameter(_ parameter: String, key: String) {
        guard let adjustService else { return }
        adjustService.addGlobalPartnerParameter(parameter, key: key)
    }

    @objc
    static func adjustRemoveGlobalPartnerParameter(for key: String) {
        instance.adjustRemoveGlobalPartnerParameter(for: key)
    }

    private func adjustRemoveGlobalPartnerParameter(for key: String) {
        guard let adjustService else { return }
        adjustService.removeGlobalPartnerParameter(for: key)
    }

    @objc
    static func adjustRemoveGlobalPartnerParameters() {
        instance.adjustRemoveGlobalPartnerParameters()
    }

    private func adjustRemoveGlobalPartnerParameters() {
        guard let adjustService else { return }
        adjustService.removeGlobalPartnerParameters()
    }

    @objc
    static func adjustTrackMeasurementConsent(_ consent: Bool) {
        instance.adjustTrackMeasurementConsent(consent)
    }

    private func adjustTrackMeasurementConsent(_ consent: Bool) {
        guard let adjustService else { return }
        adjustService.trackMeasurementConsent(consent)
    }

    @objc
    static func adjustTrackAppStoreSubscription(_ subscription: AdjustAppStoreSubscription) {
        instance.adjustTrackAppStoreSubscription(subscription)
    }

    private func adjustTrackAppStoreSubscription(_ subscription: AdjustAppStoreSubscription) {
        guard let adjustService else { return }
        adjustService.trackAppStoreSubscription(subscription)
    }

    @objc
    static func adjustRequestAppTrackingAuthorization(completionHandler: @escaping (NSNumber?) -> Void) {
        instance.adjustRequestAppTrackingAuthorization(completionHandler: completionHandler)
    }

    private func adjustRequestAppTrackingAuthorization(completionHandler: @escaping (NSNumber?) -> Void) {
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

    @objc
    static func adjustAppTrackingAuthorizationStatus() -> Int32 {
        instance.adjustAppTrackingAuthorizationStatus()
    }

    private func adjustAppTrackingAuthorizationStatus() -> Int32 {
        return adjustService?.appTrackingAuthorizationStatus() ?? 0
    }

    @objc
    static func adjustUpdateSkanConversionValue(_ value: Int, coarseValue: String?, lockWindow: NSNumber?, completion: @escaping (Error?) -> Void) {
        instance.adjustUpdateSkanConversionValue(value,
                                               coarseValue: coarseValue,
                                               lockWindow: lockWindow,
                                               completion: completion)
    }
    private func adjustUpdateSkanConversionValue(_ value: Int, coarseValue: String?, lockWindow: NSNumber?, completion: @escaping (Error?) -> Void) {
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
    static func adjustVerifyAppStorePurchase(transactionId: String,
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

    @objc
    static func adjustVerifyAndTrackAppStorePurchase(with event: AdjustEvent, completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        instance.adjustVerifyAndTrackAppStorePurchase(with: event, completion: completion)
    }

    private func adjustVerifyAndTrackAppStorePurchase(with event: AdjustEvent, completion: @escaping (AdjustPurchaseVerificationResult?) -> Void) {
        guard let adjustService else {
            completion(nil)
            return
        }
        adjustService.verifyAndTrackAppStorePurchase(with: event, completion: completion)
    }
}

private extension Tapp {
    private var adjustService: AdjustServiceProtocol? {
        return AdjustAffiliateService.shared
    }
}
