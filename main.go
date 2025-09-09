
package main

import (
	"encoding/csv"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
)

// version is set by the build process
var version = "dev"

func main() {
	// Define and parse the version flag
	showVersion := flag.Bool("v", false, "print version information")
	flag.BoolVar(showVersion, "version", false, "print version information")
	flag.Parse()

	if *showVersion {
		fmt.Printf("csv-to-json version %s\n", version)
		os.Exit(0)
	}

	// Determine input source: file or stdin
	var reader io.Reader
	if len(flag.Args()) > 0 {
		filePath := flag.Arg(0)
		file, err := os.Open(filePath)
		if err != nil {
			log.Fatalf("Error opening file: %v", err)
		}
		defer file.Close()
		reader = file
	} else {
		// Check if there is data on stdin
		stat, _ := os.Stdin.Stat()
		if (stat.Mode() & os.ModeCharDevice) != 0 {
			fmt.Println("Usage: csv-to-json [flags] <input_file_path>")
			fmt.Println("Or pipe data from stdin: cat data.csv | csv-to-json")
			os.Exit(1)
		}
		reader = os.Stdin
	}

	// Run the conversion
	if err := convert(reader, os.Stdout); err != nil {
		log.Fatalf("Error during conversion: %v", err)
	}
}

func convert(in io.Reader, out io.Writer) error {
	// Create a new CSV reader
	csvReader := csv.NewReader(in)

	// Read the header row
	header, err := csvReader.Read()
	if err == io.EOF {
		return fmt.Errorf("empty CSV input")
	}
	if err != nil {
		return fmt.Errorf("failed to read header: %w", err)
	}

	var records []map[string]string
	// Read remaining rows
	for {
		row, err := csvReader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			return fmt.Errorf("failed to read row: %w", err)
		}

		// Create a map for the current row
		record := make(map[string]string)
		for i, value := range row {
			if i < len(header) {
				record[header[i]] = value
			}
		}
		records = append(records, record)
	}

	// Marshal the records into a JSON array
	jsonData, err := json.MarshalIndent(records, "", "  ")
	if err != nil {
		return fmt.Errorf("failed to marshal JSON: %w", err)
	}

	// Write the JSON output
	_, err = out.Write(jsonData)
	if err != nil {
		return fmt.Errorf("failed to write JSON output: %w", err)
	}
	// Add a final newline for cleaner output in terminals
	_, err = out.Write([]byte("\n"))
	return err
}
