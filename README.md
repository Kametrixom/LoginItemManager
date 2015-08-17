# LoginItemManager
A simple boolean property to manage whether the current App should start on login or not

##Usage

There is only this one property:

    var startAtLogin : Bool

If it is true, then the current application will start on login. 

You can also go to System Preferences -> Users & Groups -> Login Items  where you can check if it is working (Your app name should be in there if the property is true).

You can set it just by calling

    startAtLogin = false
or

    startAtLogin = true
  
Anywhere in your app. This works because it is a global variable.

There is nothing more to this file, that's all ;)

##Notes

- Apparently the functions I'm using are deprecated, but I couldn't find an easy way to achieve the same
- This code should work for both Swift 1.2 and Swift 2.0
