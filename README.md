# Processo-Seletivo-iFood

Processo-Seletivo-iFood is a sample app, which allows the user to view a list of github repositories ordered by the number of stars.

## App Architecture

The base architecture of the project is a VIP. This architecture was chosen because it allows a unidirectional flow of data between the layers of the App's architecture, allowing a separation of layers with these having clear responsibilities and facilitating testing.

* The ViewController holds a strong reference to the Interactor and requests it to execute an event;
* The Interactor holds a strong reference to the Presenter and after processing an command generates an event that can cause a change in state and process any side effects;
* The Presenter holds a weak reference to the ViewController and after the state change it requests the ViewController to process the side effect, which can generate changes in the Layout;

ViewController ------------------------------------------------------------> Interactor 
               <------------------------ Presenter <------------------------

For navigation, an event-based Coordinator model was used with associated actions that are processed by a ViewTransition. This architecture was chosen so that we could decouple navigation from the ViewController and get reusable objects with well-defined responsibilities, thus being agnostic and functioning as plug and play.

The Networking structure was divided into two layers. The lowest level, being a client that communicates with the Networking SDK. And a Provider, present in each feature module, responsible for leaving a specific request for each use case.

For dependency injection, an abstraction with property wrappers was used on the Swinject framework.

## Screen Development

For building interfaces, the chosen framework was UIKit with ViewCode. The option for ViewCode was given by:

* Make dependency injection more natural and straightforward;
* Facilitate the process of maintaining and standardizing the project code base;
* Best for teamwork (avoids merging issues with storyboard .XML)

## Dependencies

A dependency manager was used for the project, being the [Swift Package Manager](https://github.com/apple/swift-package-manager).

### Swift Package Manager

The [Swift Package Manager](https://github.com/apple/swift-package-manager) was the tool chosen for managing external dependencies in the project, as it brings the benefit of being completely integrated with Xcode, making work more productive. Below are the external dependencies managed via SPM in this project:

* [Kingfisher](https://github.com/onevcat/Kingfisher.git)
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [Swinject](https://github.com/Swinject/Swinject.git)

## Modularization

The modularization strategy chosen was that of a monorepo divided into Swift Package Manager Packages, which contain modules that are marked as public and implicit.

A public module has only abstractions and simple models, not containing complex implementations. An implicit module, implements the abstractions of the public module.

There are three types of modules in the project:

* Main -> It can depend on all modules, but none can depend on it. It does not have the separation into Public and Implicit;
* UI -> It may depend on another Public Tool module, and any implicit feature module can depend on it;
* Tool -> It may depend on another Public Tool module, and any module can depend on the public version of it. Only Main can depend on implicit case;
* Feature -> Can depend on only Public Tools and Public Features modules, and only Main can depend on Implicit case;

This division was defined to avoid cyclic dependency, and expose only what is necessary for the modules.

The choice of this strategy was for:

* Simplify workflow by centralizing the entire code base in a single repository;
* Enable modules to build as little code as possible;
* Facilitate the visualization of the responsibility of a module.

## Trade Offs and Future Improvements

There are some improvements that can be applied to the project and that would bring scalability benefits, but that were not implemented at first:

* An architecturally integrated wrapper for sending events executed by Views;
* Creating helper methods to handle Project.Swift and module creation scripts;
* Improvements to the redux structure to make it possible to execute a greater number of methods and improve performance;
* Handle pagination events in a more scalable way.

## How to run the project

The project does not require any initial setup

**Xcode version: 14.2**
**Swift version: 5.7**

## Doubts

Any questions or problems you can contact me and I hope you like the project! =)
