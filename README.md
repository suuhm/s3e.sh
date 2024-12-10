# **S3E.sh: Simple Small Shell Editor**

**S3E.sh** is a minimalistic, shell-based text editor designed for environments where traditional editors like `nano`, `vi`, or `vim` may not be available or functional. Whether you're working on a headless system, in a containerized environment, or with restricted binaries, **S3E.sh** offers an easy-to-use alternative to quickly create and edit text files directly from the command line.

## **Why S3E.sh?**

While tools like `nano`, `vi`, and `vim` are ubiquitous in Unix-based systems, there are situations where they are either unavailable or impractical. **S3E.sh** fills this gap by offering a simple, lightweight text editor that works anywhere a bash shell is available. Some of the scenarios where this tool shines include:

- Headless systems (e.g., remote servers, IoT devices)
- Containers with minimal setups (e.g., Docker containers)
- Environments with no access to external binaries (e.g., restricted servers)

**S3E.sh** is the go-to editor when you need to manage text files on systems with minimal resources or when installing complex text editors is not feasible.

## **Features**

- **Add Multiple Lines**: Add multiple lines of text to your file in one go.
- **Delete Lines**: Easily delete a specified range of lines.
- **Replace Lines**: Replace any range of lines with new text.
- **Safe Editing**: Preview changes before saving to avoid accidental data loss.
- **Portability**: Works anywhere bash is available, without needing external binaries.
- **Minimalistic**: No complex setup or external dependencies required.

---

## **Usage**

### **Installation**

To get started, simply download or clone the repository and make the script executable:

```bash
git clone https://github.com/suuhm/s3e.sh
cd s3e.sh
chmod +x s3e.sh
```

### **Basic Usage**

Run the editor with the desired file path as an argument:

```bash
./s3e.sh myfile.txt
```

If the file does not exist, it will be created automatically. Then, you can add, delete, or replace lines in the file.

---

### **Available Options**

1. **Add Lines**: Input multiple lines of text to append to the file. Type `EOF` on a new line to finish.
2. **Delete Lines**: Specify a range of lines (e.g., `3-5`) to delete.
3. **Replace Lines**: Choose a range of lines to replace with new text.
4. **Save & Exit**: Save your changes and exit the editor.
5. **Exit Without Saving**: Exit the editor without saving changes.

---

## **Example Workflow**

1. **Start the editor**:
    ```bash
    ./s3e.sh myfile.txt
    ```

2. **Choose an option** (e.g., Add Lines, Delete Lines, etc.).

3. **Perform your edits**:
    - Add lines with `Add Lines`.
    - Replace or delete lines with `Replace Lines` or `Delete Lines`.

4. **Save & Exit** once you're done editing.

---

## **Benefits of S3E.sh**

- **Lightweight**: Perfect for minimal environments where full-featured editors aren't available.
- **No External Dependencies**: **S3E.sh** works out of the box with no need for complex installations or third-party binaries.
- **Easy to Use**: Simple command-line interface for quick text editing without distractions.
- **Highly Portable**: Works on almost any system where bash is available, making it ideal for servers, embedded systems, and containers.
- **No Hassle**: No need for configuration, just download the script, make it executable, and you're ready to go.

---

## **When to Use S3E.sh**

- **Minimalist systems**: On devices with limited resources where installing full editors like `nano` or `vi` is impractical.
- **Headless environments**: For remote servers or cloud-based instances where text editors aren't installed.
- **Restricted systems**: When you're working with systems that don't allow the installation of external binaries.
- **Scripting**: Perfect for situations where you need to modify text files from within a shell script but don't have access to a full-featured text editor.

---

## **Contributing**

If you'd like to contribute to the development of **S3E.sh**, feel free to fork the repository, submit issues, and create pull requests. This project is open-source and contributions are welcome to improve and enhance it.

---

## **License**

This project is licensed under the MIT License - see the [LICENSE] file for details.

---

### **About the Name: S3E.sh**

The name **S3E.sh** stands for **Simple Small Shell Editor**. It reflects the tool’s purpose: a simple and small editor designed to be used in shell environments with minimal resources. **S3E.sh** is a lightweight, no-frills alternative to traditional text editors, making it perfect for low-resource systems and environments where other editors might not be available.

---

### **Example Commands**

1. **Start the editor**:
    ```bash
    ./s3e.sh myfile.txt
    ```

2. **Select the action**:
    - Add lines: `Add Lines`
    - Replace lines: `Replace Lines`
    - Delete lines: `Delete Lines`

3. **Save and exit**: After editing, save and exit the editor.
