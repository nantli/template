# Welcome to Huatulquirri 🌊🏄‍♂️

To develop in this project, you need to have installed the following:

- Gum (https://github.com/charmbracelet/gum)
- Make (https://www.gnu.org/software/make/)
- Direnv (https://direnv.net/)
- Go (https://golang.org/)
- Python3 (https://www.python.org/)

If you are using macOS, you can run the following command to install all the dependencies:

```bash
# If you have Python3 and Direnv installed. cd into the project folder and run:
direnv allow
chmod +x scripts/set-up
set-up --os=macos
```

## Contributing

Before your first commit, run the following command, to set up the pre-commit hooks:

```bash
make set_up_dev
chmod +x scripts/commit
```

When your changes are ready, and for every commit, run the following command:

```bash
commit
```

---

@DevHuxAI 2023
