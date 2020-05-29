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
```
import RCNativeiOSSDK
class ViewController: UIViewController {
    override func viewDidLoad() {
        RCNativeiOSSDK.setup()
        let widget = RCNactiveJSWidgetView.init(frame: self.view.frame)
        // WidgetId is required.
        widget.setWidgetId(widgetId: "66620")
        // WidgetSubId is optional.
        widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
        // Set baseUrl 
        widget.setBaseUrl(baseUrl: "https://www.yoursite.com/article")
        self.view.addSubview(widget)
        widget.loadWidget()
    }
}

```
# License
MIT


