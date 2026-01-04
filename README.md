# fixed_sessions  

**Automatically lock your screen after focused work sessions**

WorkLock is a lightweight Linux script that:

* Starts a timer **after you unlock your screen**
* **Locks the screen after a fixed interval** (default: 45 minutes)
* **Resets the timer on every unlock**
* Optionally **notifies you when the timer starts and 1 minute before locking**
* Runs automatically on login via desktop autostart

Perfect for enforcing breaks and focused work sessions.

---

## Features

* Timer starts **after unlock**
* Locks again **45 minutes after every unlock**
* Optional notifications:
* Timer started
* 1-minute warning before lock
* Session-aware (works correctly with GNOME / systemd)
* Pure Bash, no background services required

---

## Requirements

* Linux with **systemd**
* A graphical desktop environment (GNOME, KDE, XFCE, etc.)
* `loginctl` (comes with systemd)

### Optional but recommended (for notifications)

* `notify-send`

Install notifications support if needed:

**Debian / Ubuntu**

```bash
sudo apt install libnotify-bin
```

**Arch**

```bash
sudo pacman -S libnotify
```

---

## Installation

### 1️⃣ Clone the repository

```bash
git clone https://github.com/anuragsinghbhandari/fixed_sessions.git
cd fixed_sessions
```

---

### 2️⃣ Make the script executable

```bash
chmod +x worklock.sh
```

---

### 3️⃣ Create a symlink for the command

This makes `worklock` available system-wide for your user.

```bash
mkdir -p ~/.local/bin
ln -s "$(pwd)/worklock.sh" ~/.local/bin/worklock
```

```

Verify:

```bash
which worklock
```

---

### 4️⃣ Set up autostart (recommended)

Create the autostart directory if it doesn’t exist:

```bash
mkdir -p ~/.config/autostart
```

Symlink the desktop file:

```bash
ln -s "$(pwd)/worklock.desktop" ~/.config/autostart/worklock.desktop
```

## Usage

### Normal usage

1. Log in(restart) to your desktop
2. WorkLock starts automatically
3. After **45 minutes of unlocked time**, your screen locks
4. Unlocking starts a **new 45-minute session**

---

## Notifications (optional)

If `notify-send` is installed:

* You’ll get a notification when a session starts
* You’ll get a **1-minute warning** before the screen locks

---

## Configuration

Edit `worklock.sh`:

```bash
INTERVAL=$((45 * 60))   # total session time
WARNING=60             # warning before lock (seconds)
```

Examples:

* 25 minutes: `INTERVAL=$((25 * 60))`
* 5-minute warning: `WARNING=300`

---

## Logs & Debugging

WorkLock logs to:

```bash
/tmp/worklock.log
```

View logs:

```bash
cat /tmp/worklock.log
```

Useful for debugging autostart issues.

---

## Stop WorkLock

```bash
pkill -f worklock.sh
```

---

## Uninstall

Remove symlinks (safe — does not delete the repo):

```bash
rm ~/.local/bin/worklock
rm ~/.config/autostart/worklock.desktop
```

Optionally delete the repo:

```bash
rm -rf ~/worklock
```

---

## Notes

* WorkLock is **session-aware**, not a generic CLI timer
* It is designed to be launched via **desktop autostart**
* Running it from a raw TTY may cause it to wait for a graphical session

---

## License

MIT License

---

## Motto

**Health is the wealth**
