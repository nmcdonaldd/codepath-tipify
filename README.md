# Pre-work - *Tipify*

**Tipify** is a tip calculator application for iOS.

Submitted by: **Nicholas McDonald**

Time spent: **~6** hours spent in total

###Note: I am going to branch off master and spend more time implementing the optional features below as I get time to do so.

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.
* [ ] Using locale-specific currency and currency thousands separators.
* [ ] Remembering the bill amount across app restarts (if <10mins)

The following **additional** features are implemented:

* [x] Using location-specific currency. When view loads, app locates the current country the user is in and uses that country's specific dollar/currency symbol.
* [ ] Allow the user to specifiy whether they would want to use their location for locality, or the phone's location (current default).
* [ ] Add more colors to the app for the user to choose from.
* [ ] Not really a feature, but using Autolayout constraints.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/hswD79J.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

No issues other than had to change `sender` object in the `calculateTip` function from `Any` to `AnyObject`.

## License

    Copyright [2016] [Nicholas McDonald]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
