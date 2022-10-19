# 3. Native app development

Date: 2022-04-05

## Status

Accepted

Supersedes [2. Flutter as framework for mobile app development](0002-flutter-as-framework-for-mobile-app-development.md)

## Context

With our product we will be targeting the two major mobile operating systems iOS and Android. Either there can be two seperate codebases and teams to create an application for each platform or use a cross-platform framework like react-native or Flutter with only 1 codebase compiling into applications for both platforms.

We had a look at native vs react-native vs Flutter.

## Decision

We will use native app development to create the application. We acknowledge the advantages of cross-platform development but see a higher value in the advantages of native development:

- The app should use as much native components as possible in order to be a good platform citizen (very relevant to UX).
- Some parts of the app need to be native anyway (e. g. all low-level NFC related parts) because the x-platform frameworks don't support those use cases.
- Accessibility is easier to achieve.
- Native development offers the greatest capabilities for implementing an UI because all the specific platform features are available and not only the ones that have been adopted by the x-platform framework by that time.
- Building a native UI has become as easy as using x-platform frameworks recently.
- Native development will always be the preferred (and most supported) way of develop an app when looking at the platforms individually. Relying on a x-platform framework introduces a sensitive dependency to the project.
- Native apps deliver the best performance on the devices they run on.
- x-platform frameworks introduce a huge layer that we aren't in control of and that might contain bugs that we aren't able to fix.

## Consequences

Using a cross-platform framework is driven by the motivation of reducing costs but usually introduces the cost of sacrificing the user experience.
For this app the UX is key to the success of the project. Even when aiming at the highest level of UX there is no way of resulting in a better UX than native app development could offer.
Additionally native development is the most sustainable way of building an app that should be maintained for a very long time in the future. Developers that build apps natively will definitely be available whereas developers that are familiar with a cross-platform framework that has been in fashion years ago might not be.
