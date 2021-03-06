# SDK

## Requirements
- Xcode 7.0 or later
- Deployment Target: iOS 7 or later
- Supported Devices: iPhone (4s + later), iPod Touch (5 + later), iPad (2 + later) by using upscaling
- Cocoapods installed
- Device with Wifi / 3G / LTE

## Installation
- Add the following pod dependencies to your podfile:
```
pod 'Masonry', '~> 0.6.3'
pod 'SocketRocket', '~> 0.4'
pod 'AFNetworking', '~> 2.6.3'
pod 'UIAlertView+Blocks', '~> 0.8.1'
pod 'OpenTok', '~> 2.6.1'
```
- Download the current release from and copy the idnow-sdk folder to your project directory
- Or add the repo as a git submodule (git lfs required. For the initial checkout do git lfs pull)
- Drag idnow-sdk folder into your Xcode project
- Add "Webkit.framework", "Accelerate.framework" and "libz.dylib" to your "Link binary with libraries" section
- Import 'IDnowSDK.h'

Note: To get the sample project work, you have to call "pod install" to install dependencies.

## Bitcode Support (Beta)
To enable bitcode support you have to use beta version of OpenTok.
- Remove OpenTok from the Pods file and run pods install
- Download the OpenTok Beta from https://tokbox.com/downloads/opentok-ios-sdk-2.7.2-beta.1 and include as framework
- Add the following libraries:
```
AudioToolbox.framework
AVFoundation.framework
CoreGraphics.framework
CoreMedia.framework
CoreTelephony.framework
CoreVideo.framework
Foundation.framework
GLKit.framework
libc++.dylib
libsqlite3.dylyp
OpenGLES.framework
QuartzCore.framework
SystemConfiguration.framework
UIKit.framework
VideoToolbox.framework
libz.dylib
```
- Enable bitcode support in your project

A sample bitcode project is under Sample-Bitcode/

## Settings (IDnowSettings)
The settings that should be used for the identification process provided by IDnow.

#### transactionToken
A token that will be used for instantiating a photo or video identification.

#### companyID
Your company id provided by IDnow.

#### environment
Optional: The environment that should be used for the identification (DEV, TEST, LIVE)
The default value is `IDnowEnvironmentNotDefined`. 
The used environment will then base on the prefix of the transaction token (DEV -> DEV, TST -> Test, else -> Live).
You can use the special IDnowEnvironmentCustom to define a custom IDnow installation. If this is done, you need to set the apiHost and websocketHost.

#### showErrorSuccessScreen
Optional: If set to `false`, the Error-Success-Screen provided by the SDK will not be displayed.
The default value of this property is `true`.

#### showVideoOverviewCheck
Optional: If set to `false`, the video overview check screen will not be shown befsore starting a video identification.
The default value of this property is `true`.

#### forceModalPresentation
Optional: If set to `true`, the UI for the identification will always be displayed modal. 
By default the value of this property is `false` and the identification UI will be pushed on an existing navigation controller if possible.

#### apiHost
The target server url for REST calls if custom server is used.

#### websocketHost
The target server url for websocket calls if custom server is used.

#### connectionType
The connection type to use to talk the backend. (Websocket (default) or long polling)

## Branding (IDnowAppearance)
Warning: Branding is only allowed if you have the permissions from IDnow.


### Colors

#### defaultTextColor
Optional color, that replaces the default text color.
Default: A nearly black color
Recommendation: Should be some kind of a dark color that does not collide with white color.

#### primaryBrandColor
Optional color, that replaces the default brand color.
Default: defaultTextColor
Used in headlines, checkboxes, links, alerts etc.
Recommendation: Should be a color that does not collide with white color.

#### proceedButtonBackgroundColor
Optional color, that replaces the default color of textfield backgrounds and borders
Default: defaultTextColor

#### textFieldColor
Optional color, that replaces the default color of textfield backgrounds and borders
Default: defaultTextColor

#### failureColor
Optional color, that replaces the text color in the result screen, when an identification failed.
Default: A red color

#### successColor
Optional color, that replaces the text color in the result screen, when an identification was successful.
Default: A green color


### Status Bar

#### enableStatusBarStyleLightContent
Optional: Forces the light status bar style to match dark navigation bars.
If you tint your navigation bar with a dark color by adjusting navigation bar appearance (e.g. a blue color) you can set this value to true. The statusbar style will then be adjusted to light in screens where the navigation bar is visible.


### Fonts

#### fontNameRegular
An optional font name that can be used to replace the regular font used by the SDK.
Default: System Font: Helvetica Neue Regular (< iOS 9), San Francisco Regular (>= iOS 9)

#### fontNameMedium
An optional font name that can be used to replace the medium font used by the SDK.
Default: System Font: Helvetica Neue Medium (< iOS 9), San Francisco Medium (>= iOS 9)

#### fontNameLight
An optional font name that can be used to replace the light font used by the SDK.
Default: System Font: Helvetica Neue Light (< iOS 9), San Francisco Light (>= iOS 9)


## Usage example:

```objective-c

// Setup IDnowAppearance
IDnowAppearance *appearance = [IDnowAppearance sharedAppearance];
    
// Adjust colors
appearance.defaultTextColor = [UIColor blackColor];
appearance.primaryBrandColor = [UIColor blueColor];
appearance.proceedButtonBackgroundColor = [UIColor orangeColor];
appearance.failureColor = [UIColor redColor];
appearance.successColor = [UIColor greenColor];
    
// Adjust statusbar
appearance.enableStatusBarStyleLightContent = YES;
    
// Adjust fonts
appearance.fontNameRegular = @"AmericanTypewriter";
appearance.fontNameLight = @"AmericanTypewriter-Light";
appearance.fontNameMedium = @"AmericanTypewriter-CondensedBold";

// To adjust navigation bar / bar button items etc. you should follow Apples UIAppearance protocol.

// Setup IDnowSettings
IDnowSettings *settings = [IDnowSettings settingsWithCompanyID:@"yourCompanyIdentifier"];
settings.transactionToken = @"DEV-TXTXT";
settings.showErrorSuccessScreen = NO;
settings.showVideoOverviewCheck = NO;
settings.forceModalPresentation = YES;

//Enable custom server with long polling
settings.environment = IDnowEnvironmentCustom;
settings.apiHost = "https://api.yourserver.com";
settings.websocketHost = "https://websocket.yourserver.com";
settings.connectionType = IDnowConnectionTypeLongPolling;

// Initialise and start identification
IDnowController *idnowController = [[IDnowController alloc] initWithSettings: settings];

// Initialize identification using blocks 
// (alternatively you can set the delegate and implement the IDnowControllerDelegate protocol)
[idnowController initializeWithCompletionBlock: ^(bool success, NSError *error, bool canceledByUser)
{
		if ( success )
		{
		      // Start identification using blocks
			  [idnowController startIdentificationFromViewController: self 
			  withCompletionBlock: ^(bool success, NSError *error, bool canceledByUser)
			  {
					  if ( success )
					  {
					      // identification was successfull
					  }
					  else
					  {
					      // identification failed / canceled
					  }
				}];
		}
		else if ( error )
		{
		      // Present an alert containing localized error description
			  UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"Error" 
			  message: error.localizedDescription 
			  preferredStyle: UIAlertControllerStyleAlert];
			  UIAlertAction *action = [UIAlertAction actionWithTitle: @"Ok" 
			  style: UIAlertActionStyleCancel 
			  handler: nil];
			  [alertController addAction: action];
			  [self presentViewController: alertController animated: true completion: nil];
		}
	}];
```


## Localization
Warning: Adapting localizations is only allowed if you have the permissions from IDnow.

English and German Localizations are provided by the SDK (IDnowSDKLocalization.bundle)
You can overwrite localisation in your own Localizable.strings files.


### Example:
```
//Defined in the IDnowSDKLocalization.bundle
"NAVIGATION_ITEM_TITLE_DEFAULT" = "IDnow";

//Overwrite in your Localizable.strings file:
"NAVIGATION_ITEM_TITLE_DEFAULT" = "Video Ident";
```
