# Introduction:
Revcontent's iOS library written in Swift for enables you quickly and reliably include our JS widgets into your application.

# Prerequisites
- XCode Version >= 10.x
- iOS Version >=10.0

# Features
- Load widget by WidgetId
- Load widget by SubId (Optional)
- Flexible widget size
- Define Base URL with FQDN or Article URL
- Add widget programmatically or by creating IBOutlets from Storyboard/Xibs.
# Installation
- Create a new project in Xcode as you would normally `for e.g. MyApp`.
- Open a terminal window, and `$ cd` into your project directory.
- Create a Podfile. This can be done by running `$ pod init`
- Open your Podfile. The first line should specify the platform and version supported.
- In order to use CocoaPods you need to define the Xcode target to link them to. So for example if you are writing an iOS app, it would be the name of your app. Create a target section by writing target '$TARGET_NAME' do and an end a few lines after.
```
platform :ios, '10.0'
target 'MyApp' do
  pod 'RCNativeiOSSDK'
end
```
- Save your Podfile.
- Run `$ pod install`
- Open the `MyApp.xcworkspace` that was created. This should be the file you use everyday to create your app.

# Usage

 ### Initialisation SDK
 
Should be called before widget usage.

```
RCNativeiOSSDK.setup()
```
### Widget usage

Create widget view.
```swift  
lazy var widgetView: RCNactiveJSWidgetView = {
  let widget = RCNactiveJSWidgetView(containerView: "put_here_container_for_widget")
  // WidgetId is required.
  widget.setWidgetId(widgetId: "put_your_widget_id")
  // WidgetSubId is optional.
  widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
  // baseUrl is optional.
  widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
  // GDPR is optional
  widget.setGDPRConsent("put_your_base64encoded_consent", isEnabled: nil)
  // CCPA is optional
  widget.setCCPA("put_your_CCPA_consent_string")
  return widget
}()

```

Example of using.

```swift
class ViewController: UIViewController {

  @IBOutlet var widgetContainerView: UIView!

  lazy var widgetView: RCNactiveJSWidgetView = {
    let widget = RCNactiveJSWidgetView(containerView: widgetContainerView)
    // WidgetId is required.
    widget.setWidgetId(widgetId: widgetId)
    // WidgetSubId is optional.
    widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
    // baseUrl is optional.
    widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
    // GDPR is optional
    widget.setGDPRConsent("put_your_base64encoded_consent", isEnabled: nil)
    // CCPA is optional
    widget.setCCPA("put_your_CCPA_consent_string")
    widget.delegate = self
    return widget
  }()
  
  var widgetId : String = "someWidgetId"

  override func viewDidLoad() {
    super.viewDidLoad()
    RCNativeiOSSDK.setup()
    widgetView.loadWidget()
  }
}

```

Clear cache

```swift
//You can clear cache by this method. 
widgetView.clearCache()
```

Conform your view controller to  ```RCNativeJSWidgetViewDelegate``` and get information about widgetView height.

### Slider Unit usage

Create slider unit.
```swift  
lazy var bottomSlider: RCNativeSliderBanner = {
  let slider = RCNativeSliderBanner(bannerId: "put_your_banner_id", size: RCNativeSliderBanner.BannerSize)
  slider.delegate = self
  slider.presentingController = self
  return slider
}()
```

Use ```showImmediatelyAfterLoad``` property to manage when slider unit should be shown(by default `true`).

Conform your view controller to  ```RCNativeSliderBannerDelegate``` and get information about slider unit events. 
```swift  
public protocol RCNativeSliderBannerDelegate: class {
  func sliderBannerDidLoad(_ banner: RCNativeSliderBanner)
  func sliderBannerWillAppear(_ banner: RCNativeSliderBanner)
  func sliderBannerDidAppear(_ banner: RCNativeSliderBanner)
  func sliderBannerDidSelect(_ banner: RCNativeSliderBanner)
  func sliderBannerWillClose(_ banner: RCNativeSliderBanner)
  func sliderBannerDidClose(_ banner: RCNativeSliderBanner)
}
```


### GDPR
The General Data Protection Regulation (GDPR) is the toughest privacy and security law in the world. Though it was drafted and passed by the European Union (EU), it imposes obligations onto organizations anywhere, so long as they target or collect data related to people in the EU. The regulation was put into effect on May 25, 2018. 

Revcontent's widget supports GDPR consent parameters.
In order to provide user's GDPR consent status you can implement your own or third party [CMP](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/Mobile%20In-App%20Consent%20APIs%20v1.0%20Final.md).
You can also check the [demo app](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/tree/master/In-App%20Reference/Android) provided by IAB
The parameters are optional and can be passed to Revcontent's widget via below method, which should be called before loadWidget() method:
```
// boolean value, which determines if GDPR is applicable.
let isGDPRApplicable = true
// GDPR consent string is IAB standard URL-safe base64 encoded value.
let gdprConsent = "your_base64encoded_consent"
widgetView.setGDPRConsent(gdprConsent, isEnabled: isGDPRApplicable)
// GDPR consent info should be provided before this method call:
widgetView.loadWidget()
```

### CCPA
The California Consumer Privacy Act (CCPA) is a law that allows any California consumer to demand to see all the information a company has saved on them, as well as a full list of all the third parties that data is shared with. In addition, the California law allows consumers to sue companies if the privacy guidelines are violated, even if there is no breach.

Revcontent's widget supports CCPA consent parameter.
In order to provide user's CCPA consent status you should get [US Privacy String](https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md).
The parameter is optional and can be passed to Revcontent's widget via below method, which should be called before loadWidget() method:
```
// CCPA consent string. Is IAB standard URL-encoded U.S. Privacy string.
let ccpaConsent = "your_CCPA_consent_string"
widgetView.setCCPA(ccpaConsent)
//CCPA consent info should be provided before this method call
widgetView.loadWidget()
```
# Changelog

History of all changes is avaliable [here](Changelog.md).

# Ads.txt for Publishers

## What is Ads.txt?
Ads.txt is an initiative founded by the [IAB Technology Laboratory](https://iabtechlab.com) to increase transparency in the programmatic landscape. The goal is to ensure publishers’ inventory is only sold through authorized partners to prevent counterfeiting in addition to providing advertisers more control over their purchased inventory.

## What exactly is ads.txt?
- Authorized Digital Sellers (ads.txt for short) is an IAB initiative to improve transparency and reduce fraud in programmatic advertising.
- Ads.txt is a publicly available file that publishers create and add to their websites. The file is plain text and contains the names of the authorized networks that have permission to sell their inventory.

## How does ads.txt benefit me?
- The Ads.txt file can help protect your brand from counterfeit inventory that is intentionally mislabeled as originating from a specific domain, app, or video.
- Declaring authorized sellers will open up more demand as many buyers will not purchase inventory unless they have an ads.txt file outlining authorized to sellers

## How do I create a .txt file?
Create your file as a text (.txt) using Notepad or a similar program.
- Your file should be hosted at the root level for your domain.Example: <https://example.com/ads.txt>
-Root Domain is defined as one level down from the [Public Suffix List](https://publicsuffix.org/list/), which is also how it is defined in the [IAB ads.txt specification](https://iabtechlab.com/ads-txt/). Example: google.co.uk would be considered a root domain as co.uk is on the [Public Suffix List](https://publicsuffix.org/list/), but maps.google.co.uk would not be considered a root domain.  

## What information is included in an ads.txt file?
Publishers should include a separate line in the file for each authorized seller. Each line in a publisher’s ads.txt list requires three pieces of data (plus a fourth optional field)
-  <Field #1>, <Field #2>, <Field #3>, <Field #4>
-  The domain name of the advertising system (required) Example: revcontent.com
- Publisher’s Account ID (required) Example: 12345 (Your publisher ID for Revcontent)
- Type of Account/Relationship (required) DIRECT - A direct business contract between the publisher and the advertising system RESELLER - Publishers who do not directly control the account indicated in  should specify RESELLER NOTE: This field is case-sensitive and should always be in all-caps for both DIRECT and RESELLER
- Certification Authority ID (optional) A current certification authority is the Trustworty Accountability Group (TAG), and the TAG ID would be included here.

**Information that needs to be in your ads.txt file as a publisher with Revcontent should be copied directly from the list found inside of your account settings. [Click here](https://www.revcontent.com/ads_txt) to go directly to the relevant page.**

**How do I create an ads.txt file in DFP?**
Check out [Google’s Step-By-Step Guide](https://support.google.com/dfp_premium/answer/7544382) on ads.txt management in DFP.

**Need more Information?**
You can learn more about this IAB initiative [here](https://iabtechlab.com/ads-txt/). For more information from Revcontent, feel free to reach out to your Publisher Account Representative.

# License
MIT


