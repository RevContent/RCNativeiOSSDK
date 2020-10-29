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

# License
MIT


