.PHONY: generate_project clean

generate_project:
	@echo "Generating Xcode project..."
	xcodegen generate
	@echo "Xcode project generated successfully."

clean:
	@echo "Cleaning up..."
	rm -rf *.xcodeproj
	@echo "Cleanup completed."

setup: clean generate_project
	@echo "Setup completed."

open:
	xed CleanArchWithUIKitDemo.xcodeproj

format:
	@echo "Formatting Swift code..."
	swiftformat .