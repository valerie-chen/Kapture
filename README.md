# Kapture
CodePath project #3 — my own version of Instagram

Submitted by: Valerie Chen

Time spent: 30 hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can sign up to create a new account using Parse authentication
* [X] User can log in and log out of his or her account
* [X] The current signed in user is persisted across app restarts
* [X] User can take a photo, add a caption, and post it to "Instagram"
* [X] User can view the last 20 posts submitted to "Instagram"
* [X] User can pull to refresh the last 20 posts submitted to "Instagram"
* [X] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
* [X] User can tap a post to view post details, including timestamp and caption. 
* [X] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user.

The following **optional** features are implemented:
* [X] Show the username and creation time for each post
* [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse



## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://media.giphy.com/media/3oEjI0ytVZEWs1R960/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/3oEjI381JjfjadMa6k/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/l41YuuEPx2GFVfENa/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIFs created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

This was the first time I've used a tab bar, and I had some trouble dealing with navigation between bars. PFQuery and uses of PFObject also caused some issues, mostly because it took me a while to understand what those things are and how they are structured.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [Parse](https://github.com/ParsePlatform/parse-server)
- [ParseUI](https://github.com/ParsePlatform/ParseUI-iOS)
- [DateTools](https://github.com/MatthewYork/DateTools) - Configures dates in the Facebook style (3 minutes ago, Just now, etc.)
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD) - Progress bar
- icons courtesy of iconmonstr.com and downloadicons.net

## License

    Copyright [2016] [Valerie Chen]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
