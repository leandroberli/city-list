## City list iOS Application

For this project, the MVVM architecture was adopted as it is one of the most popular, easy to understand, keeps the view/business logic layers separated, and simplifies testing.

#About search optimization:

The API Response brings too large data and we have a large numbers of cities. The data size is very significant and some operations are expensive.
We would recommend some backend changes. A pagination implementation would be nice. But as it was required, we had to adapt to the current response without backend changes.

After the Xcode Instruments analysis we have detected that the City initialization, sorting and filtering are the most expensive operations. 
So, we have decided to run these tasks in a background thread to avoid blocking the user experience

For developing the layout in landscape mode, NavigationSplitView (https://developer.apple.com/design/human-interface-guidelines/split-views) was initially considered, but a custom solution was chosen due to issues in achieving the correct layout on iPhone devices.
In my opinion, it would be worthwhile to dedicate time to implement this component provided by Apple.
