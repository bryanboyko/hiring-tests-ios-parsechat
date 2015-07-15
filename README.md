## iOS Test: Parse Chat

This test requires you to build a chat client using Parse and Facebook user authentication. To complete this app, you should set up a [Parse](https://parse.com/) project, and a Facebook app to handle oauth. The app functions as a single chat room, where any user who downloads the app can post messages to the room for all other members to see. 

Build an app that satisfies the user stories below. We want to see how you think about application development and design, so we've left it up to you to decide how the app will be implemented.

Time spent: `<Number of hours spent>`

### Features

#### Required

- [ ] User can sign in using Facebook OAuth login flow (should install facebook credentials in the .plist file)
- [ ] User can see all messages in a chat room (messages should be read from parse)
- [ ] User can see timestamps for all messages in the chat room
- [ ] User can compose and post messages to all users (messages shuold be stored in parse)
- [ ] User can see name and Facebook profile picture next to their chat messages (image should load asyncronously)
- [ ] User can "pull to refresh" the chat room messages

#### Optional

- [ ] User can see messages appear immediately in the chat room after they post them, without waiting for a refresh from Parse
- [ ] User can see new messages from other users immediately without a refresh (instead of the pull to refresh feature)
- [ ] User can delete messages they've sent
- [ ] User can sign out
