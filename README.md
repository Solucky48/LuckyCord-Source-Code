# Luckycord Source Code v1.0

Welcome to the official source code repository for Luckycord, a lightweight, decentralized, peer-to-peer (P2P) chat application built using Godot 4 and its ENetMultiplayerPeer networking system. 

By making this project open source, you can freely view, modify, and build upon the core networking logic.

Created by Solucky48.

---

## About the Source Code

This repository contains the raw development files required to edit or compile Luckycord yourself. If you are a developer or a curious user, you can use these files to:
* Study Godot 4 high-level multiplayer systems (RPCs).
* Modify the chat UI or theme layouts.
* Add features such as private direct messaging or file sharing.
* Export your own custom binaries for Windows, macOS, or Linux.

---

## Features

* Pure P2P Network Architecture: Direct peer-to-peer connection ensures lower latency and server-independent private chats.
* Custom Room Names: Hosts can easily name their chat spaces.
* Profile Personalization: Set your custom username and chat tag color before joining.
* Dynamic Chat History: Supports BBCode formatting for server alerts and distinct user naming styles.
* Built-in Dark Mode: Toggle background themes easily for comfortable night viewing.

---

## How to Run or Edit the Code

To open and run this project locally, you will need the Godot Engine:

1. Download and install Godot 4.x (Standard Version).
2. Clone this repository or download the source ZIP file to your computer.
3. Open the Godot Project Manager, click "Import", and select the `project.godot` file from this folder.
4. Press F5 within the editor to run and test the application.

---

## How to Connect and Play (using Hamachi)

Because Luckycord utilizes direct P2P networking, all participants must be on the same virtual or local network. 

### Prerequisites
1. Download and install LogMeIn Hamachi (or an equivalent like Radmin VPN).
2. Ensure everyone joining the chat is connected to the same Hamachi network room.

### As the Host
1. Copy your Hamachi IPv4 address (e.g., 25.xx.xx.xx).
2. Share this IP address with your friends.
3. Open Luckycord, configure your name/color, input a room name, and click Create/Host.

### As a Client (Joining)
1. Get the Host's Hamachi IPv4 address.
2. Open Luckycord, configure your name and color profile.
3. Click Join, paste the Host's IP into the address field, and connect!

---

## Troubleshooting Connection Issues

* Stuck on Joining / Connection Timed Out: Windows Firewall frequently flags custom P2P executable traffic. If you cannot connect, the Host must go to Windows Defender Firewall -> Allow an app through firewall and ensure Luckycord is checked for both Private and Public networks.
* Hamachi Relay Tunnel Error: Right-click your friend's name in Hamachi and select Ping. If the requests time out, Hamachi's virtual adapter is being blocked by a local firewall or third-party antivirus software.

---

## Tech Stack

* Engine: Godot 4.x
* Language: GDScript
* Protocol: ENet (UDP)

---
Developed by [Solucky48](https://github.com/Solucky48)
