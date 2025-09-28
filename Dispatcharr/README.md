# Dispatcharr Home Assistant Add-on (Not yet working for Arm processors - sorry)

IPTV & stream management with seamless Home Assistant integration.

## About

This add-on wraps Dispatcharr in a Home Assistant add-on, providing:

- 📺 IPTV stream management
- 📹 Automated recording capabilities  
- 🔗 **Shared recordings** accessible to other Home Assistant add-ons (Plex, Jellyfin, etc.)
- ⚙️ Configurable recording locations
- 🏠 Full Home Assistant integration

## Features

- **Shared Storage Integration**: Recordings are automatically stored in Home Assistant's media folder (`/media/dispatcharr` by default)
- **Custom Paths**: Configure custom recording locations
- **Cross-Add-on Compatibility**: Recordings accessible to Plex, Jellyfin, and other media add-ons
- **Automatic Migration**: Existing recordings are automatically moved to shared storage
- **Home Assistant Panel**: Direct access from Home Assistant sidebar

## Installation

### Method 1: Add Repository (Recommended)

1. Navigate to **Supervisor** → **Add-on Store** in Home Assistant
2. Click the menu (⋮) in the top right → **Repositories**
3. Add this repository: `https://github.com/Stainy3244/homeassistant-addons/dispatcharr`
4. Find "Dispatcharr" in the add-on store and click **Install**

### Method 2: Manual Installation

1. Copy the `homeassistant-addon` folder to `/addons/dispatcharr/` on your Home Assistant system
2. Restart Home Assistant
3. Navigate to **Supervisor** → **Add-on Store**
4. Find "Dispatcharr" and click **Install**

## Configuration

### Basic Configuration

The add-on works out of the box with these defaults:

```yaml
recordings_path: "/media/dispatcharr"
log_level: "info"
```

### Advanced Configuration

```yaml
recordings_path: "/media/dispatcharr"        # Default shared location
custom_path: "/share/recordings"             # Optional: custom recording path  
log_level: "debug"                           # Logging level
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `recordings_path` | string | `/media/dispatcharr` | Default location for recordings |
| `custom_path` | string | (empty) | Custom recording location (overrides default) |
| `log_level` | list | `info` | Log level: trace, debug, info, notice, warning, error, fatal |

## Usage

1. **Start the add-on** and optionally enable auto-start
2. **Access the interface** at `http://your-ha-ip:9191` or via the Home Assistant sidebar
3. **Configure your IPTV sources** in Dispatcharr
4. **Set up recordings** - they'll automatically be saved to the shared location
5. **Access recordings in other add-ons** like Plex at `/media/dispatcharr`

## Integration with Other Add-ons

### Plex Integration

1. Ensure your Plex add-on has `share:rw` in its configuration
2. Add a library in Plex pointing to `/media/dispatcharr`
3. Recordings will automatically appear in Plex

### Jellyfin Integration

1. Configure Jellyfin to access `/media/dispatcharr`
2. Add as a media library
3. Recordings will be automatically discovered

## Troubleshooting

### Recordings Not Appearing in Shared Folder

1. Check the add-on logs for symlink creation messages
2. Verify the symlink exists: `/data/recordings -> /media/dispatcharr`
3. Restart the add-on if needed

### Cannot Access from Other Add-ons

1. Ensure other add-ons have `share:rw` mapping
2. Check that `/media/dispatcharr` exists and contains files
3. Verify file permissions

### Performance Issues

- Consider using a custom path on faster storage
- Monitor disk space in the shared folder
- Adjust log level to reduce logging overhead

## Support

- 🐛 [Report Issues](https://github.com/Stainy3244/dispatcharr/issues) (This is my first attempt at a Github repo support may be slow or non-existant!) 
- 💬 [Home Assistant Community](https://community.home-assistant.io/)
- 📖 [Original Dispatcharr Documentation](https://github.com/dispatcharr/dispatcharr)

## Changelog

### 0.10.0
- Initial Home Assistant add-on release
- Shared storage integration
- Configurable recording paths
- Home Assistant panel integration

[commits-shield]: https://img.shields.io/github/commit-activity/y/Stainy3244/dispatcharr.svg
[commits]: https://github.com/Stainy3244/dispatcharr/commits/main
[releases-shield]: https://img.shields.io/github/release/Stainy3244/dispatcharr.svg
[releases]: https://github.com/Stainy3244/dispatcharr/releases
