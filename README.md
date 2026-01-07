# Microwave-Man!

Titled Games' submission for the [Game Off 2025](https://itch.io/jam/game-off-2025).

This is a Godot project: [Godot Docs](https://docs.godotengine.org/en/stable/)

## Play Online

The game is automatically deployed to GitHub Pages when a new release is created:

- **Stable releases** (e.g., `v1.0.0`): Available at the root URL
- **Pre-releases** (e.g., `v1.0.0-beta.1`, `v0.9.0-alpha`): Available at `/beta`

## Development

### Creating a Release

When you push a new tag, the GitHub Actions workflow will:

1. Build the game for multiple platforms (Windows, Linux, macOS, Web, PCK)
2. Create a GitHub release with all build artifacts
3. Deploy the web build to GitHub Pages:
   - Stable releases go to the root directory
   - Pre-releases (tags containing `alpha`, `beta`, `rc`, or `pre`) go to the `/beta` directory

Example:
```bash
# Create and push a stable release
git tag v1.0.0
git push origin v1.0.0

# Create and push a beta release
git tag v1.0.0-beta.1
git push origin v1.0.0-beta.1
```
