# Accelo App

Demo App for Accelo showing crime map of London

## Accelo Crime API

Implemented `HttpClient` class to handle HTTP requests to the API and decodes the response to any `Decodable` type object.

All API responses will be conforming to this closure, using the `Result` type:
>  `HttpCompletionClosure<T> = ((Result<T, HttpError>) -> Void)`

`T` would need to conform to `Decodable` protocol, and errors will be extended using the `HttpError` enum states

## Client-side App

The app architecture is built using the MVVM pattern and Protocol-oriented programming and Dependency Injection principles.

Moving through the map will continually append crime data pulled from the UK Police API into the map via markers. 
Tapping on the marker will show further details on the offence committed in the area.

## Dependencies

- Swiftlint
- GoogleMaps
- GooglePlaces

## Testing

`AcceloTests`
- `testExample`: provides simple testing on parsing data

## Installation

open terminal
```
cd /your/path/to/accelo/project/
pod install
```
