# Dotfiles

Clean Mac dev setup: **Oh My Zsh**, **nvm**, **Cursor**, **OrbStack**, and CLI tools. No iTerm2 — use Cursor’s terminal (or any terminal).

**What you get**

- **Oh My Zsh** + `robbyrussell` theme
- Git autocomplete + autosuggestions
- **nvm** + Node LTS
- **Cursor** (main IDE + terminal)
- **OrbStack**
- Flycut, autojump, fzf, bat, eza, ripgrep
- One **dotfiles repo** as the single source of truth
- A **`doctor`** command to verify everything

---

## 0. One-time macOS prerequisite

```bash
xcode-select --install
```

---

## 1. Clone this repo

Clone to any directory (e.g. `~/dotfiles` or `~/Documents/developer/dotfiles`):

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

---

## 2. Repo structure

```
dotfiles/
├── Brewfile
├── bootstrap.sh
├── install.sh
├── bin/
│   ├── link
│   └── doctor
└── config/
    ├── zsh/
    │   ├── zshrc
    │   ├── exports.zsh
    │   ├── aliases.zsh
    │   └── plugins.zsh
    └── git/
        ├── gitconfig.template   # tracked
        ├── gitconfig            # generated, gitignored
        └── gitignore_global
```

---

## 3. Run setup

From the repo directory:

```bash
chmod +x bootstrap.sh install.sh
./bootstrap.sh
./install.sh
exec zsh
doctor
```

- **`bootstrap.sh`** — Installs Homebrew (if needed), sets up PATH, and generates `config/git/gitconfig` from the template if it doesn’t exist.
- **`install.sh`** — Runs `brew bundle`, installs Oh My Zsh, symlinks `.zshrc`, `.gitconfig`, `.gitignore_global`, and installs Node LTS via nvm.
- **`exec zsh`** — Reloads your shell so the new config is active.
- **`doctor`** — Checks that brew, git, node, nvm, fzf, autojump, Oh My Zsh, and symlinks are present. After `exec zsh`, `doctor` is on your `PATH` (via `config/zsh/exports.zsh`). In **bash**, run `~/dotfiles/bin/doctor` (or add `~/dotfiles/bin` to `PATH`).

**Linux / WSL:** macOS already ships **zsh**; on Ubuntu/WSL you need a zsh binary before Oh My Zsh works. The Brewfile includes **`zsh`** so `brew bundle` installs it. If **`./install.sh` stops early** because `brew bundle` failed, nothing after that runs — including Oh My Zsh and the **`~/.zshrc` symlink**. Fix the bundle errors (or install missing formulae), then run **`./install.sh` again**. To repair only shell setup after `brew bundle` succeeds:

```bash
brew install zsh   # skip if already installed via brew bundle
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
~/dotfiles/bin/link ~/dotfiles/config/zsh/zshrc ~/.zshrc
```

**Bash and .NET:** `dotnet` comes from Homebrew’s **`dotnet@8`** formula. Your **zsh** config loads it via `config/shell/dotnet-homebrew.sh` (sourced from `exports.zsh`). In **bash**, Homebrew and .NET are not on `PATH` until you load them — for example:

```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
export DOTFILES="$HOME/dotfiles"
source "$DOTFILES/config/shell/dotnet-homebrew.sh"
```

Then `dotnet --version` should print the SDK version. If it still fails, install the formula: `brew install dotnet@8`.

---

## 4. Git config (your identity)

`config/git/gitconfig` is **not** tracked. It is created from `config/git/gitconfig.template` the first time you run `bootstrap.sh`.

Edit it and set your name and email:

```bash
# Open the file (path depends on where you cloned the repo)
cursor ~/dotfiles/config/git/gitconfig
```

Uncomment and set:

```ini
[user]
	name = Your Name
	email = your@email.com
```

---

## 5. Optional: Flycut at login

- **System Settings → Login Items** → enable **Flycut** so the clipboard manager starts on login.

---

## 6. Verify setup

```bash
brew --version
git --version
node -v
nvm --version
git ch<TAB>   # tab completion
doctor
```

You should see the **robbyrussell** prompt, e.g.:

```
➜  ~ git:(main)
```

---

## Mental model

| Step           | Purpose              |
|----------------|----------------------|
| `bootstrap.sh` | Prepare the machine  |
| `install.sh`   | Apply your identity  |
| `exec zsh`     | Activate config      |
| `doctor`       | Verify health        |

---

## New Mac

On a fresh MacBook:

```bash
xcode-select --install
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
./install.sh
exec zsh
doctor
```

Then edit `config/git/gitconfig` with your name and email.
