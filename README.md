# MXC_APPLICATION
With the release of Android 9.0 (API level 28) there came a new version of support libraries under the banner, AndroidX. These versions are incompatible to the earlier plugins and packages used by Flutter and consequently by the MVC framework package I would soon be releasing. And so, in the interest of the Flutter community, I decided on something about it.
[![mxc_application](https://user-images.githubusercontent.com/32497443/54296406-46140a80-458b-11e9-82cf-926321d985fd.png)](https://medium.com/p/468f7c3d94c6/)
# MVC_Application With An X
I decided to deliver a 'pre-release' of the framework package. One that will still work with the now deprecated and yet currently more widely used support files. While the standard package, mvc_application, will continue on with the most recent and future Android support files, this release will only work with the support files available prior to AndroidX. I decided to call it, mxc_application. With its subtle 'play on words' this will be an early release of the 'MVC framework package.'
# Keep It Here
Thus, this version of the framework is everything like the MVC version, but for one important distinction. One that's reflected in the list of versions numbers found in the framework's pubspec.yaml file. They're all the old versions of the plugins and packages that worked prior to the migration to AndroidX.
![pubspec.yaml](https://user-images.githubusercontent.com/32497443/54296699-c5094300-458b-11e9-9e0c-b60a86d9aa90.png)
![stop](https://user-images.githubusercontent.com/32497443/54297065-6ee8cf80-458c-11e9-8277-7b43d30d4de6.png)Note, this particular framework package will not progress any much further in development. After all, it's only really helpful to those developing apps for the Android platform using deprecated support library files that will one day go away.

Turn to the Medium article, [MXC before MVC](https://medium.com/p/468f7c3d94c6/), for further instructions and documentation.