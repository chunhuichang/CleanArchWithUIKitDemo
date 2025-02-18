# Clean Architecture Template

[English](README.md) | [中文](README_zh.md)

This is an iOS application template designed based on **Clean Architecture** principles. 
It provides a solid foundation for building **scalable**, **maintainable**, and **testable** iOS applications.

## Features
- Clean Architecture Design: Implements a clear separation of concerns by dividing the project into distinct layers, promoting organized and maintainable code.
- UI Integration: Supports both **UIKit** and **SwiftUI**, demonstrating how to structure a Clean Architecture project with either framework.
- Testing: Includes **unit tests** and **integration tests** to ensure application reliability and correctness.


## Clean Architecture Structure
- Application
    - Handles app lifecycle and dependency injection.
- Infrastructure
    - Manages third-party integrations, logging, networking, and local storage.
    - Provides implementations of external services (e.g., API clients, database managers).
- Data
    - Defines repositories and data sources (e.g., remote APIs, local databases).
    - Transforms raw data into domain models.
- Domain
    - Contains business logic and use cases.
    - Defines entities and interacts with repositories to process data.
- Presentation
    - Manages UI components (ViewControllers in UIKit or Views in SwiftUI).
    - Interacts with ViewModels to update the UI with processed data.
- Mock
    - Provides mock implementations of repositories and services for testing.
    - Used in unit tests to simulate real-world scenarios.