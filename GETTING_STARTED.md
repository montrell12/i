# Getting Started with EcommerceApp

This guide will help you get the Swift ecommerce app running on your Mac.

## Prerequisites

- macOS 12.0 or later
- Xcode 14.0 or later
- iOS 15.0+ device or simulator

## Quick Start

### Option 1: Using Xcode (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/montrell12/i.git
   cd i
   ```

2. **Open in Xcode**
   ```bash
   open Package.swift
   ```
   
   This will open the project in Xcode as a Swift Package.

3. **Create a new iOS App target**
   - In Xcode, go to File > New > Target
   - Select "App" under iOS
   - Name it "EcommerceApp"
   - Select SwiftUI for Interface
   - Click Finish

4. **Replace the default App file**
   - Delete the default `EcommerceAppApp.swift` file
   - Add the `EcommerceExampleApp.swift` file from the repository root
   - Make sure to add the EcommerceApp package as a dependency

5. **Run the app**
   - Select an iOS simulator (iPhone 14 or later recommended)
   - Press ⌘R to build and run

### Option 2: Create a New Xcode Project

1. **Create a new iOS App project**
   - Open Xcode
   - File > New > Project
   - Select iOS > App
   - Product Name: "EcommerceApp"
   - Interface: SwiftUI
   - Language: Swift

2. **Add the EcommerceApp package**
   - In Xcode, select File > Add Packages
   - Enter the repository URL: `https://github.com/montrell12/i.git`
   - Click "Add Package"

3. **Update your App file**
   - Replace the contents of your main app file with:
   ```swift
   import SwiftUI
   import EcommerceApp

   @main
   struct YourAppName: App {
       var body: some Scene {
           WindowGroup {
               EcommerceAppView()
           }
       }
   }
   ```

4. **Run the app**
   - Select an iOS simulator
   - Press ⌘R to build and run

### Option 3: Using Swift Playgrounds (iPad)

1. Create a new App project in Swift Playgrounds
2. Copy the source files from `Sources/EcommerceApp/` into your project
3. Replace the main ContentView with EcommerceAppView
4. Run the app on your iPad

## Running Tests

To run the unit tests:

1. Open the package in Xcode
2. Press ⌘U to run all tests
3. Or use the Test Navigator (⌘5) to run individual test suites

You can also run tests from the command line on macOS:
```bash
swift test
```

## Project Structure

The app is organized as a Swift Package with the following structure:

```
EcommerceApp/
├── Sources/EcommerceApp/       # Main source files
│   ├── Models/
│   │   ├── Product.swift
│   │   └── CartItem.swift
│   ├── ViewModels/
│   │   ├── ShoppingCart.swift
│   │   └── ProductRepository.swift
│   └── Views/
│       ├── EcommerceAppView.swift
│       ├── ProductListView.swift
│       ├── ProductDetailView.swift
│       ├── CartView.swift
│       └── CheckoutView.swift
└── Tests/EcommerceAppTests/    # Unit tests
    ├── ProductTests.swift
    ├── ShoppingCartTests.swift
    └── ProductRepositoryTests.swift
```

## Troubleshooting

### "No such module 'SwiftUI'" error
This error occurs when trying to build on non-macOS systems. SwiftUI is only available on Apple platforms. Make sure you're building on macOS with Xcode.

### Build fails in Xcode
1. Make sure you're running macOS 12.0+
2. Update Xcode to version 14.0 or later
3. Clean build folder: Product > Clean Build Folder (⌘⇧K)
4. Try closing and reopening Xcode

### Simulator not showing up
1. Open Xcode > Preferences > Platforms
2. Make sure iOS simulator is installed
3. Try restarting Xcode

## Next Steps

Once you have the app running:

1. **Explore the UI**: Navigate through the product list, view details, and add items to cart
2. **Modify Products**: Edit `ProductRepository.swift` to add your own products
3. **Customize Styling**: Modify the view files to match your design
4. **Add Features**: Extend the app with user authentication, order history, etc.

## Need Help?

- Check the main README.md for detailed documentation
- Review the code comments in each source file
- Open an issue on GitHub for bugs or questions

## Development Tips

- Use Xcode's preview feature to quickly iterate on UI changes
- Run tests frequently to catch regressions
- Use the SwiftUI inspector (⌘⌥I) to debug view hierarchies
- Enable Swift strict concurrency checking for better code quality
