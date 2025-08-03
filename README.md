# MySQL CLI Session Recorder

This is a shell scripting-based tool to **interact with MySQL server via CLI** and **automatically log full session data** (commands + output) into both `.log` and `.html` formats for review or record-keeping.

## 🔍 Project Description

By default, MySQL CLI does not log or save session commands and their outputs unless explicitly configured. This tool bridges that gap by providing:

* A **generic SQL session runner** (`sql.sh`)
* A **question-driven interactive practice session** (`questions.sh`)
* **Auto-saving of session** in:

  * `output_filename.log` – for raw CLI logs
  * `output_filename.html` – for a nicely formatted viewable HTML report

## 📁 Project Structure

```
.
├── .my.cnf            # MySQL credentials file (username & password)
├── questions.txt      # List of SQL practice questions
├── questions.sh       # Interactive shell script for practice mode
├── sql.sh             # Universal MySQL session recorder
└── README.md          # Project documentation
```

---

## ⚙️ Prerequisites

* MySQL server installed and accessible via command line.
* A valid `.my.cnf` file to bypass manual login each time.

Example `.my.cnf`:

```ini
[client]
user=your_mysql_user
password=your_password
```

---

## 🚀 Usage

### 1. Run Generic SQL Session (like MySQL CLI with logging)

```bash
bash sql.sh
```

🎥 [Watch Demo Video](https://s3.eu-north-1.amazonaws.com/jibeshroy.static.dev/Projects/mysql-shell/Code_woEGAyBaKL.mp4)

* Prompts for a **file name** to save session output.
* Lets you run any SQL command.
* Saves command and output to:

  * `yourname.log`
  * `yourname.html`

### 2. Practice Using Questions from File

```bash
bash questions.sh
```

🎥 [Watch Demo Video](https://s3.eu-north-1.amazonaws.com/jibeshroy.static.dev/Projects/mysql-shell/Code_eT3DHoV7Z4.mp4)

* Loads questions from `questions.txt`
* Prompts for answers in SQL form
* Records both the **question**, **answer**, and **output**
* Automatically renders into an HTML file

---

## ✍️ Adding Your Own Questions

Simply add questions line-by-line in `questions.txt`:

```txt
1. Show all databases.
2. Create a table named 'users' with id and name.
3. Insert a record into 'users'.
4. Select all from 'users'.
```

The script will display them interactively.

---

## 📄 Output Files

After every session:

* `yourfilename.log` contains plain text logs of the entire session.
* `yourfilename.html` is auto-generated with a clean readable format (clickable & styled).

Both will be created in the project root.

---

## 📦 Features

* ✅ Interactive CLI prompt like MySQL
* ✅ Pre-filled credentials (via `.my.cnf`)
* ✅ Logs full session (commands + output)
* ✅ Auto-generates HTML report
* ✅ Supports dynamic database switching (`USE db_name`)
* ✅ Error handling & message formatting

---

## 🛑 Exit the Session

Simply type:

```bash
exit
```

---
## 📌 Notes

* Make sure the `.my.cnf` path is correctly set inside the scripts.
* You can adjust the script to add timestamps or styling if needed.

---
