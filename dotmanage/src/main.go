package main

import (
	"os"
	"runtime"
)

type Platform string

const PlatformString (
	Win Platform = "Windows",
	Mac Platform   = "macOS",
	Linux Platform   = "Linux",
}

type ConfigDatabase interfact {
	
}

func main() {

	if len(os.Args) < 2 {
		println("No command provided")
		return
	}

	cmd := os.Args[1]

	switch cmd {
	case "platform":
		platformCommand()
	default:
		println("Unknown command:", cmd)
	}

}

// Detect the current system and print it to the console
func platformCommand() {
	var platform string
	switch os := runtime.GOOS; os {
	case "windows":
		platform = "Windows"
	case "darwin":
		platform = "macOS"
	case "linux":
		platform = "Linux"
	default:
		platform = "Unknown"
	}
	println("Current platform:", platform)
}

