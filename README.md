## DriveG Vapor server

Make sure to have Xcode installed. It can be found in the macOS App Store. **After Xcode is installed, make sure to run it at least once and install the Command Line Tools.**

Run the following script to make sure Vapor can be installed: `eval "$(curl -sL check.vapor.sh)"`

Install **Homebrew**: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

After **Homebrew** is installed, run the following commands in **Terminal**: 
`brew tap vapor/homebrew-tap`

`brew update` 

`brew install vapor`

Navigate to the Vapor directory and run `vapor update -y`

This will fetch all the dependencies, generate a new Xcode project and open the project in Xcode. This will take some time.

In Xcode, make sure to select the **Run** scheme on your Mac and then press the big **Play** button.

The Vapor server will launch and it will be accessible at `http://localhost:8080`