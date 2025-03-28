You have set up a Custom URL Scheme (smartredirect), but Universal Links require Associated Domains.

This means your app expects links like smartredirect://openproduct/152244, which won't work with email deep links.

If your email link is https://yourdomain.com/smartredirect/openproduct/152244, this won't trigger the app.

If you want Universal Links (Recommended), do the following:

Go to Xcode → Target → Signing & Capabilities → Add "Associated Domains".

Add: applinks:yourdomain.com

Make sure your AASA file is hosted correctly.

Handle deep links in application(_:continue:restorationHandler:) (AppDelegate).
