# Gojo-RentHub : Home rent mobile app

## Introduction

Welcome to our Flutter Gojo-RentHub home rent mobile app project! Gojo-RentHub is designed to simplify the process of finding and renting homes, offering a seamless experience for both tenants and landlords. This project showcases the capabilities of Flutter in building a robust and feature-rich application for all sector.

## Getting Started

Before you begin contributing, make sure you have the following prerequisites installed:

- Flutter SDK(Latest stable version): [Install Flutter](https://flutter.dev/docs/get-started/install)

Clone the repository to your local machine:

```bash
git clone https://github.com/your-username/Gojo-RentHub.git
cd flutter-ecommerce-capstone
```

Install dependencies:

```bash
flutter pub get
```

## Project Structure

The project is organized into the following main directories:

- **lib**: Contains the Dart code for the Flutter application.
- **assets**: Includes static assets such as images and fonts.
- **test**: Houses unit and widget tests.


lib directory is organized into the following sub directories:

- **lib**: Contains the Dart code for the Flutter application.
  - **shared**: Shared functionalities and components across different modules.
  - **house**:
    - **repo/services**: Contains repositories and services related to house management.
    - **bloc**: Houses business logic components using the BLoC pattern for house-related features.
    - **presentation**: Contains screens and widgets for displaying house-related information and interactions.
  - **auth**:
    - **repo/services**: Includes repositories and services related to authentication and user management.
    - **bloc**: Houses business logic components using the BLoC pattern for authentication and user-related features.
    - **presentation**: Contains screens and widgets for authentication flows and user management.
  - **profile**:
    - **repo/services**: Consists of repositories and services related to user profiles and settings.
    - **bloc**: Contains business logic components using the BLoC pattern for profile-related features.
    - **presentation**: Contains screens and widgets for displaying user profiles and managing profile settings.

N.B: You can add new features not mentioned above

## Contributing Guidelines

1. **Fork the Repository**: Click the "Fork" button at the top right corner of the repository to create your copy.

2. **Create a Branch**: For each new feature or bug fix, create a new branch with a descriptive name:

   ```bash
   git checkout -b your-feature-name
   ```

3. **Commit Changes**: Make your changes, and commit them with clear and concise messages:

   ```bash
   git commit -m "Add feature/fix: description"
   ```

4. **Push Changes**: Push your changes to your forked repository:

   ```bash
   git push origin your-feature-name
   ```

5. **Submit a Pull Request**: Open a pull request from your forked repository to the main project repository.

6. **Code Review**: Expect feedback and be responsive to comments. Make necessary changes and update your pull request.

7. **Merge**: Once your pull request is approved, it will be merged into the main branch.

## Code Style

Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) for code formatting. Make sure to run `dart format` before committing your changes.

## Issues and Discussions

Feel free to open issues for bug reports, feature requests, or any other concerns. Join our discussions in the GitHub repository to share ideas and insights.

## Acknowledgments

Thank you for being the contributor to Flutter Gojo-RentHub Project. 

Happy coding!

[The Broker Boyz]

