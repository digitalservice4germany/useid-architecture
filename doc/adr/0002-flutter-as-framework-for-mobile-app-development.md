# 2. Flutter as framework for mobile app development

Date: 2022-03-18

## Status

Superseded by [3. Native app development](0003-native-app-development.md)

## Context

With our product we will be targeting the two major mobile operating system iOS and Android. Either there can be two seperate codebases and teams to create an application for each platform or use a cross-platform framework like react-native or Flutter with only 1 codebase compiling into applications for both platforms.

We had a look at native vs react-native vs Flutter.

## Decision

We will use the cross-platform framework Flutter to create the application for the following reasons:

- maintain only 1 codebase
- have both platform specific applications on feature parity
- implement a similar UX/UI on both platforms
- as Flutter uses Dart, it is more natural for our current team compared to learning Swift and Kotlin
- Flutter is snappier and offers better performance compared to react-native when looking at cross platform frameworks
- we could possibly maintain the codebase longer after an initial heavy lifting phase

## Consequences

The most obvious consequences are the following:

- learn Flutter and Dart by and to create prototypes,
- seek professional help for the difficult aspects of getting started,
- native library bindings need to be created from dart to the respective platform.
