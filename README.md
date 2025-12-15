You have set up a Custom URL Scheme (smartredirect), but Universal Links require Associated Domains.

This means your app expects links like smartredirect://openproduct/152244, which won't work with email deep links.

If your email link is https://yourdomain.com/smartredirect/openproduct/152244, this won't trigger the app.

If you want Universal Links (Recommended), do the following:

Go to Xcode → Target → Signing & Capabilities → Add "Associated Domains".

Add: applinks:yourdomain.com

Make sure your AASA file is hosted correctly.

Handle deep links in application(_:continue:restorationHandler:) (AppDelegate).


///==================//

𝗦𝘄𝗶𝗳𝘁 𝗧𝗶𝗽 𝗼𝗳 𝘁𝗵𝗲 𝗗𝗮𝘆 💡

Recently, I got a task in a legacy iOS project:
 “𝗖𝗵𝗮𝗻𝗴𝗲 𝘁𝗵𝗲 𝗳𝗼𝗻𝘁 𝗮𝗰𝗿𝗼𝘀𝘀 𝘁𝗵𝗲 𝗲𝗻𝘁𝗶𝗿𝗲 𝗮𝗽𝗽.”

 It sounded simple. Just a Find & Replace in Xcode, right?
Nope 🥲 .

 Reality slapped me in 10 seconds.
❌ 𝗫𝗰𝗼𝗱𝗲 𝗰𝗮𝗻 𝗳𝗶𝗻𝗱 𝗳𝗼𝗻𝘁 𝗻𝗮𝗺𝗲𝘀 𝗶𝗻𝘀𝗶𝗱𝗲 𝗦𝘁𝗼𝗿𝘆𝗯𝗼𝗮𝗿𝗱/𝗫𝗜𝗕 XML…
 But it cannot replace them using Find & Replace.
 It only replaces strings inside Swift/Objective-C files.

🛠️ 𝗧𝗵𝗲 𝗧𝗲𝗿𝗺𝗶𝗻𝗮𝗹 𝗧𝗿𝗶𝗰𝗸 𝗧𝗵𝗮𝘁 𝗦𝗮𝘃𝗲𝗱 𝘁𝗵𝗲 𝗗𝗮𝘆
Here’s the exact method I used to replace every
 𝗣𝗼𝗽𝗽𝗶𝗻𝘀-𝗥𝗲𝗴𝘂𝗹𝗮𝗿 → 𝗖𝗼𝗱𝗲𝗰𝗣𝗿𝗼-𝗥𝗲𝗴𝘂𝗹𝗮𝗿
 across all Storyboards in seconds.

𝗳𝗶𝗻𝗱 . -𝗻𝗮𝗺𝗲 "*.𝘀𝘁𝗼𝗿𝘆𝗯𝗼𝗮𝗿𝗱" -𝗲𝘅𝗲𝗰 𝘀𝗲𝗱 -𝗶 '' '𝘀/𝗣𝗼𝗽𝗽𝗶𝗻𝘀-𝗥𝗲𝗴𝘂𝗹𝗮𝗿/𝗖𝗼𝗱𝗲𝗰𝗣𝗿𝗼-𝗥𝗲𝗴𝘂𝗹𝗮𝗿/𝗴' {} +

