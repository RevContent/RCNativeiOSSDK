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
Conform your view controller to  ```RCNativeJSWidgetViewDelegate``` and get information about widgetView height.

 ### Initialisation SDK
 
Should be called before widget usage.

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
-Root Domain is defined as one level down from the [Public Suffix List](https://publicsuffix.org/list/), which is also how it is defined in the [IAB ads.txt specification](https://iabtechlab.com/ads-txt/). Example: <google.co.uk> would be considered a root domain as co.uk is on the [Public Suffix List](https://publicsuffix.org/list/), but maps.google.co.uk would not be considered a root domain.  

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


