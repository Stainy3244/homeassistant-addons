# WatchState Add-on Documentation

## Configuration

The add-on requires minimal configuration. Here are the available options:

### Option: `UID`

The User ID that the container should run as. This is important for file permissions.

**Default**: `1000`

```yaml
UID: 1000
```

### Option: `GID`

The Group ID that the container should run as. This is important for file permissions.

**Default**: `1000`

```yaml
GID: 1000
```

## Getting Started

### 1. Start the Add-on

After installation, start the add-on and check the logs for any errors.

### 2. Access the Web UI

The Web UI is available at:
- `http://homeassistant.local:8080`
- `http://YOUR_HOME_ASSISTANT_IP:8080`

### 3. Initial Setup

On first access, you'll be prompted to create a system user. This is a one-time operation.

### 4. Add Your Media Servers

1. Click the help button (❓) in the top right
2. Choose your sync method:
   - **One-Way Sync**: One primary server syncs to others
   - **Two-Way Sync**: All servers sync bidirectionally
3. Follow the setup wizard

### 5. Configure Backends

For each media server:
- Enter the server URL
- Provide API token or credentials
- Test the connection
- Save the configuration

#### Getting API Tokens

**Plex:**
1. Open Plex Web App
2. Settings → Account → Security
3. Or extract from URL: https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/

**Jellyfin:**
1. Dashboard → API Keys
2. Click the + button to create a new key
3. Name it "WatchState"
4. Copy the generated key

**Emby:**
1. Similar process to Jellyfin
2. Dashboard → Advanced → API Keys

### 6. Import Data

After configuring backends:
1. Navigate to Tasks or Import
2. Click "Import Now" for each backend
3. Wait for the initial import to complete
4. Check the logs for any errors

## Sync Methods

### Scheduled Tasks

- Automatic imports on a schedule
- Configurable interval (recommended: 30-60 minutes)
- Reliable fallback method
- Configure in the Tasks section

### Webhooks

Real-time sync when events occur on your media servers.

#### Setting Up Webhooks

**Plex:**
1. Settings → Webhooks
2. Click "Add Webhook"
3. Paste the URL from WatchState backend page
4. Save

**Jellyfin:**
1. Dashboard → Plugins → Catalog
2. Install "Webhook" plugin
3. Configure with WatchState webhook URL

**Emby:**
1. Dashboard → Server → Webhooks
2. Add webhook
3. Configure with WatchState URL

**Important**: Even with webhooks, keep scheduled tasks enabled to catch any missed events.

### Manual Import

Trigger imports manually from the Tasks page when needed.

## Data Storage

All data is stored in `/config/watchstate` which includes:
- SQLite database
- Configuration files
- Logs
- Backup files

This directory is automatically included in Home Assistant snapshots.

## Troubleshooting

### Permission Issues

If you see permission errors in the logs:

1. Check the owner of `/config/watchstate`
2. Adjust the UID/GID in the add-on configuration to match
3. Restart the add-on

### Connection Issues

If WatchState can't connect to your media servers:

1. Verify the URLs are correct and accessible
2. Check API tokens are valid
3. Ensure there are no firewall rules blocking access
4. Test connectivity from Home Assistant terminal

### Webhook Not Working

1. Verify the webhook URL is copied correctly
2. Check WatchState logs when triggering an event
3. Ensure the media server can reach Home Assistant
4. Test with manual import as a fallback

### High CPU/Memory Usage

During initial import, resource usage may be high. This is normal and should stabilize after the first sync completes.

## Advanced Usage

### Multi-User Support

WatchState supports mapping users between different media servers. Configure user mappings in the backend settings.

### Backup and Restore

#### Creating Backups

1. Go to the Backup section in WatchState UI
2. Click "Create Backup"
3. Download the generated file
4. Store securely

#### Restoring from Backup

1. Go to the Backup section
2. Upload your backup file
3. Click "Restore"
4. Wait for the process to complete

### Parity Checks

Use the parity check feature to verify your media servers are reporting consistent data for the same content.

### Finding Duplicates

WatchState can search for duplicate file references across backends, useful if multiple servers reference the same media files.

## Performance Optimization

- Use webhooks for real-time updates instead of very frequent scheduled tasks
- Keep scheduled task interval reasonable (30-60 minutes)
- Monitor logs for any recurring errors
- Clean up old logs periodically

## Security Considerations

- WatchState stores media server credentials securely
- Access to the Web UI should be restricted (consider using Home Assistant's ingress or authentication proxy)
- Keep API tokens secure and regenerate if compromised
- Regular backups ensure you can recover from any issues

## Updating

The add-on uses the latest WatchState image. To update:

1. Go to the add-on page
2. Click "Rebuild" to pull the latest image
3. Or wait for Home Assistant to notify you of updates
4. Restart after updating

## Support

- WatchState GitHub: https://github.com/arabcoders/watchstate
- FAQ: https://github.com/arabcoders/watchstate/blob/master/FAQ.md
- Guides: https://github.com/arabcoders/watchstate/blob/master/guides
- Discord: https://discord.gg/haUXHJyj6Y

For add-on specific issues, report at: https://github.com/Stainy3244/homeassistant-addons/issues
