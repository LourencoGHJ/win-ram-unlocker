
# 🚀 Universal RAM Unlocker & Optimizer (by CONNECT Labs)

[⬅️ Back to Main Menu](./README.md)

![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

A lightweight, automated multilingual batch script designed to fix the notorious Windows bug where massive amounts of physical memory (RAM) get falsely allocated as **"Hardware Reserved"** or trapped in the **"Standby List"**.

> 💡 **Creator's Note (Gui - CONNECT):**
> *I built and refined this tool because it genuinely solved my issue. My Windows was locking up my physical memory, forcing my PC to boot up using an absurd **23GB of RAM** out of nowhere. After applying this script, my boot usage instantly dropped back to a clean and normal **6GB**!*

---

## 📸 Before & After (Visual Evidence)

Inside the `/screenshots` folder, you can see the diagnostic proofs:
* **Before:** Windows Task Manager showing a massive chunk of RAM locked under "Hardware Reserved" or extreme system cache bloat.
* **After:** Full system memory restored, ready for gaming (Valorant, CS) and heavy workloads.

---

## 🛠️ Step-by-Step Restoration Guide

To completely fix your memory allocation, follow these steps in order:

### Step 1: Diagnose with RAMMap
1. Open the **RAMMap** tool you downloaded from Microsoft Sysinternals.
2. Look at the **Use Counts** tab.
3. Check the **"Driver Locked"** and **"Standby"** columns. If these numbers are unusually high, your Windows kernel is mismanaging your hardware layer.

### Step 2: Run the Automated Script
1. Download the `Otimizador_RAM.bat` file from this repository.
2. Right-click the file and select **"Run as Administrator"** (Crucial, as it modifies boot variables and system registry layers).
3. Select your preferred language: **[2] English**.
4. Read the warning prompt and choose **Option [1] Run Full Diagnostic and Unlock**.
5. When prompted, type `Y` to **reboot your PC**.

### Step 3: Verify the Fix
After the reboot, open your **Task Manager** -> **Performance** -> **Memory**. You will see that the "Hardware Reserved" memory has dropped dramatically, giving you back your full RAM capacity.

---

## 🔍 What this Script Actually Does Under the Hood

Unlike sketchy "RAM cleaners" that just dump active processes, this tool targets the root system variables:
1. **BCDEdit Reset:** Clears hidden memory truncation and maximum memory limitations (`removememory` / `truncatememory`) mistakenly set inside `msconfig`.
2. **Registry IO Re-mapping:** Adjusts `ClearPageFileAtShutdown` and `LargeSystemCache` inside the kernel memory management registry to force hardware release upon system cycles.
3. **Cache & Explorer Flush:** Safely kills and restarts the Windows Explorer subsystem while performing a total flush of internal system cache tables and DNS.
4. **Active Background Garbage Collection:** Directs a hidden background host command via PowerShell Engine (`[System.GC]::Collect()`) to force the OS to release dead pages from unhooked hardware drivers.

---

## 🤝 Contributing & Sharing

If this script saved your gaming performance or workflow, feel free to:
* ⭐ **Star** this repository so more people can find it.
* 🔄 Share the link with friends facing FPS drops on Discord and tech forums.
