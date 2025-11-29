# Home Assistant Add-on: WatchState

Self-hosted service to sync your Plex, Jellyfin and Emby play state without relying on 3rd-party external services.

## About

WatchState is a tool that helps you sync your media server users' play state across multiple backends. It supports:

- **Management via WebUI**
- **Sub-users support**
- **Sync backends play state** (Many-to-Many or One-Way)
- **Backup your backends play state** into portable format
- **Receive webhook events** from media backends
- **Find un-matched or mis-matched items**
- **Search your backend metadata**
- **Check parity** between media servers
- **Sync watch progress** via webhooks or scheduled tasks

Supported media servers: Jellyfin, Plex, and Emby.

## Installation

1. Add this repository to your Home Assistant addons store
2. Install the "WatchState" addon
3. Start the addon
4. Access the WebUI at `http://homeassistant.local:8080` (or your Home Assistant IP)

## Configuration

The addon has minimal configuration options:

### Option: `UID`

User ID to run the container as. Default: `1000`

### Option: `GID`

Group ID to run the container as. Default: `1000`

## First Time Setup

1. After starting the addon, access the WebUI
2. You will be prompted to create a new system user (one-time operation)
3. Click on the help button in the top right corner
4. Choose your sync method:
   - **One-way sync**: Import play state from one backend to others
   - **Two-way sync**: Sync play state between all backends
5. Add your media server backends and configure them
6. Import your initial data

## Data Import Methods

WatchState supports three methods to import data from backends:

1. **Scheduled Tasks**: Pull data from backends on a schedule
2. **On Demand**: Manually trigger import tasks
3. **Webhooks**: Receive real-time events from backends

**Note**: Even if using webhooks, keep scheduled imports enabled to catch any missed events.

## Usage

After configuration, WatchState will:

- Monitor play state across your configured media servers
- Sync watched status, progress, and ratings
- Handle multi-user environments
- Provide detailed reports on sync status

## Support

- [GitHub Repository](https://github.com/arabcoders/watchstate)
- [FAQ](https://github.com/arabcoders/watchstate/blob/master/FAQ.md)
- [Guides](https://github.com/arabcoders/watchstate/blob/master/guides)
- [Discord Server](https://discord.gg/haUXHJyj6Y)

## Data Storage

All data is stored in the Home Assistant `/config/watchstate` directory. This includes:

- Database files
- Configuration files
- Logs
- Backup files
