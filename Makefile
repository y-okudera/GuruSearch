xcode: ## Select latest version of Xcode
	sudo xcode-select --switch /Applications/Xcode.app/

bootstrap: ## Install ruby tools
	mint bootstrap
	bundle config set path 'vendor/bundle'
	bundler install

project: ## Generate Xcode project and workspace
	mint run Carthage carthage bootstrap --platform iOS --cache-builds
	bundle exec pod install

open: ## Open xcworkspace
	open GuruSearch.xcworkspace

update: ## Update tool versions
	brew update
	brew upgrade
	mint bootstrap
	bundle update

clean: ## Clean generated files
	rm -rf GuruSearch.xcworkspace
	rm -rf Pods/
