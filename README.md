#  Readme

## Architecture

1. App uses MVVM architecture
2. Deployment target: 15.4 (to match Wikipedia App)
3. Network service and router are injected providing better testability

## Structure

App consists of two main components
1. List of the locations
2. Form to create a new location

## Accessibility

I've tried to add some pinch of accessibility for labels and buttons, but capabilities are limitless there

## Possible improvements
- Better navigation stack
- Add persistance so user-entered location could be retained between sessions
- Error processing, user-friendly alerting
- More unit tests (currently coverage is not sufficient)
- Better UI (I caught myself on overthinking about it, so had to slap my hands tried to add some fancy bells & whistles)

