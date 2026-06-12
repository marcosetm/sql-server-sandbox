# Backup and Restore Cycle

1. Create a full backup with `backup database`
1. Inspect the backup content with `restore filelistonly`
1. Restore to a new database with `restore database...with move...`
1. Verify/query the new database to make sure data comes back correctly
# Creating a Backup

```sql
backup database wine_cellar
to disk = '/var/opt/mssql/backup/wine_cellar.bak'
with format, init, name = 'wine_cellar-Full'
```

`format` — initializes the backup media from *scratch.* Writes a new media header and overwrites *anything* previously on that backup file. Use when creating a fresh, first-time backup file

`init` — overwrites the first backup set on the media. Combine with `format` it means "start fresh and don't append anything to any existing backup."

`name` — descriptive label for the backup set. This is a human readable name stored in the backup metadata.
# Get Logical Filenames in the Backup

The following command will produce a table/list of the `LogicalNames` that will be needed to run the restore command.

```sql
restore filelistonly
from disk = '/var/opt/mssql/backup/wine_cellar.bak';
```

The backup file created is like an image that contains two logical volumes. The result showed the two files which are:
- `wine_cellar` — the data file (`.mdf`), type `D` for data
- `wine_cellar_log` — the log file (`.ldf`), type `L` for log
# Restore

The `restore` command requires explicitly mapping each logical file to a physical path on the target server. With the above information, the restore command is

```sql
restore database wine_cellar_restored
from disk = '/var/opt/mssql/backup/wine_cellar.bak'
with move 'wine_cellar' to '/var/opt/mssql/data/wine_cellar_restored.mdf',
	 move 'wine_cellar_log' to '/var/opt/mssql/data/wine_cellar_log_restored.ldf';
```
