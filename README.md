# extension-vk
Haxe OpenFL extension for VK, supports VK SDK (*now only getting authentication token*) for Android and iOS. (inspired by extension-facebook)

## How to Install

### Requirements

```bash
haxelib install inthebox-macros
haxelib install extension-android-support-v4
```

### iOS

It needs to add the lines below to your Info.plist (It may be templated by you to override OpenFl's).

```xml
<key>LSApplicationQueriesSchemes</key> 
<array> 
    <string>vk</string> 
    <string>vk-share</string> 
    <string>vkauthorize</string> 
</array>

<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>vk::ENV_VK_APP_ID::</string>
            </array>
        </dict>
    </array>
```

Assume you have several auth processors (e.g. VK and Facebook) but yoy can have only one SDLUIKitDelegate.
So these auth processors should be combined in one delegate. You can use our approach to have project-specific extension.

Copy the folder "sample-include" in your project and change Build.xml and SDLUIKitDelegate.mm for your needs.

### Android

It needs to add the lines below to your AndroidManifest.xml (It may be templated by you to override OpenFl's).

```xml
<activity android:name="com.vk.sdk.VKServiceActivity" android:label="ServiceActivity" android:theme="@style/VK.Transparent" />
```
### Project.xml

Once this is done, you just need to add this to your project.xml
```xml
<haxelib name="extension-vk" />
<include path="include" if="ios" />
 <setenv name="VK_APP_ID" value="xxx" />
```

Detailed information about SDK [iOS](https://vk.com/dev/ios_sdk), [Android](https://vk.com/dev/android_sdk)


## Usage example

Login the user to VK if needed:
```Haxe
import extension.vk.VK;

var vk:VK = VK.getInstance();

vk.init(VK_APP_ID, function(value:Bool){ trace("Init Callback"); });

vk.login(               // Show login dialog
    ["email"],
    onLoggedIn,
    onFailed,
    onError
  );
}
```

## License

The MIT License (MIT) - [LICENSE.md](LICENSE.md)
