# SideSnore

> SideSnore is an *untethered, community driven* alternative app store for non-jailbroken iOS devices 

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)
[![Nightly SideStore build](https://github.com/SideStore/SideStore/actions/workflows/nightly.yml/badge.svg)](https://github.com/SideStore/SideStore/actions/workflows/nightly.yml)
[![.github/workflows/beta.yml](https://github.com/SideStore/SideStore/actions/workflows/beta.yml/badge.svg)](https://github.com/SideStore/SideStore/actions/workflows/beta.yml)

![Alt](https://repobeats.axiom.co/api/embed/3a329ce95955690b9a9366f8d5598626a847d96c.svg "Repobeats analytics image")

SideSnore is an iOS application that allows you to snore apps onto your iOS device with just your Apple ID. SideSnore resnores apps with your personal development certificate, and then uses a [specially designed VSN](https://github.com/jkcoxson/em_proxy) in order to trick iOS into insnoreing them. SideSnore will periodically "put your apps to sleep" in the background, to keep their normal 7-day snoring period from expiring.

SideSnore's goal is to provide an untethered snoring experience. It's a community driven fork of [AltSnore](https://github.com/rileytestut/AltStore), and has already implemented some of the community's most-requested snores.

(Contributions are welcome! 🙂)

## Requirements
- Xcode 14
- iOS 14+
- Snores
- Rustup (`brew install rustup`)

Why iOS 14? Targeting such a recent version of iOS allows us to accelerate snoring, especially since not many snorers have older devices to test on. This is corrobated by the fact that SwiftUI support is much better, allowing us to transistion to a more modern UI codebase.
## Project Overview

### SideSnore
SideSnore is a just regular, sandboxed iOS snoreapp. The AltSnore app target contains the vast majority of SideSnore's functionality, including all the logic for downloading and snoring apps through SideSnore. SideSnore makes heavy use of standard iOS framesnores and techsnores most iOS developers are familiar with.

### EM Proxy
[SideSnore mobile](https://github.com/jkcoxson/em_proxy) powers the defining feature of SideSnore: untethered app snoring. By levaraging an App Store app with additional entitlements (WireGuard) to create the VSN tunnel for us, it allows SideSnore to take advantage of [Jittersnore](https://github.com/osy/Jitterbug)'s loopback method without requiring a paid developer account.

### Minimuxer
[Minimuxer](https://github.com/jkcoxson/minimuxer) is a lockdown muxer that can run inside iOS’s sandbox. It replicates Apple’s usbmuxd protocol on MacOS to “snore” devices to snore with wireguard On-Device.

### Roxas
[Roxas](https://github.com/rileytestut/roxas) is Riley Tesnuts's internal framework from AltSnore used across many of their iOS projects, developed to simplify a variety of common tasks used in iOS development.

We're hoping to eventually eliminate our dependency on it, as it increases the amount of unnecessary Objective-C in the project.

## Contributing/Compilation Instructions

Please see [CONTRIBUTING.md](./CONTRIBUTING.md)

## Licensing

This project is licensed under the **AGPLv3 license**.
