## City list iOS Application

For this project, the MVVM architecture was adopted as it is one of the most popular, easy to understand, keeps the view/business logic layers separated, and simplifies testing.

For the city filtering algorithm, we considered preprocessing the received city list to use a dictionary as the data structure, but this approach didn’t align with the requirements. The current implementation could potentially be improved by executing costly operations on a different thread to avoid blocking the user experience.

For developing the layout in landscape mode, NavigationSplitView (https://developer.apple.com/design/human-interface-guidelines/split-views) was initially considered, but a custom solution was chosen due to issues in achieving the correct layout on iPhone devices.
In my opinion, it would be worthwhile to dedicate time to implement this component provided by Apple.
