Hey there! Thank you so much for you review :)

## Build and run:
Xcode iOS version 16.0+
Run Maestro: 
ShareTheMealApp > Scripts > maestro-flow.yaml
run: maestro test maestro-flow.yaml (make sure simulator is set)

## A short summary of the approach:
<img width="2607" height="2408" alt="Group 77" src="https://github.com/user-attachments/assets/576fff0f-df1f-4182-b3b0-e197bb543d69" />
I used a classic MVVM reactive approach. Both the Network Layer (JSON file in this case) and the Image Cache interact with the ViewModel, which handles presenting data to the views. User input flows in the opposite direction, through the ViewModel, and updates are propagated to other views via observation.

## Optimizations:
- All images are cached.
- Used pagination to load lazily load meal programs when the user scrolls down.
- Used a LazyVStack to make sure views are not created all at once.
- JSON items are only loaded once.

## Trade offs:
- Due to times constraints I did not test all classes but I tested the majority of them (both UI and regular unit tests).
- If i had more time I would add an animation, like in the main app to show the inline navbar when the user scrolls passed the image, to **MealProgramDetailView**.

## Video:
https://github.com/user-attachments/assets/3a1051bb-86dc-4b02-af51-51e71acaed72

