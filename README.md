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
class ViewController: UIViewController
{
    // Instance
    var tableData = ["Example Full Screen", "Example 1/3 Of Screen", "Example 1/8 Of Screen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: UITableview Datasource Methods
extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

// MARK: UITableview Delegate Method
extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            let vc = storyboard?.instantiateViewController(identifier: "ShowWidgetViewController") as? ShowWidgetViewController
            vc!.widgetCount = 1
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 1
        {
            let vc = storyboard?.instantiateViewController(identifier: "ShowWidgetViewController") as? ShowWidgetViewController
            vc!.widgetCount = 3
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(identifier: "ShowWidgetViewController") as? ShowWidgetViewController
            vc!.widgetCount = 8
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}


//MARK:- ShowWidgetViewController For Create Multipel widget

class ShowWidgetViewController: UIViewController {

    // Instance
    var widgetCount = 0
    let widgetID = ["66620","66620","66620","66620","66620","66620","66620","66620"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Status Bar Height
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        // Naviagtion Bar Height
        let navBarHeight = statusBarHeight +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        // Device Height
        let deviceHeight = self.view.bounds.height - navBarHeight
        
        // Create Widget on views
        for i in 0..<widgetCount
        {
            let Yvalue = CGFloat(i)*deviceHeight/CGFloat(widgetCount)
            let viewWidget = UIView.init(frame: CGRect(x: 0, y: (Yvalue + navBarHeight) , width: self.view.bounds.width, height: deviceHeight/CGFloat(widgetCount)))
            viewWidget.backgroundColor = .random()
            viewWidget.addSubview(self.widgetParam(widgetID[i]))
            self.view.addSubview(viewWidget)
        }
    }
    
    // RCNactiveJSWidgetView For Ad
    func widgetParam(_ widId : String) -> RCNactiveJSWidgetView
    {
        RCNativeiOSSDK.setup()
        let widget = RCNactiveJSWidgetView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/CGFloat(widgetCount)))
        // WidgetId is required.
        widget.backgroundColor = .random()
        widget.setWidgetId(widgetId: widId)
        // WidgetSubId is optional.
        widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
        // baseUrl is optional.
        widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
        //self.view.addSubview(widget)
        widget.loadWidget()
        return widget
    }
}
// Random color to define rows
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}



```
# License
MIT


